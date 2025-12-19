# modules/home/lee/flake-update-notify.nix
{ config, pkgs, lib, ... }:

let
  flakeDir = "/home/lee/etc/nixos";

  # How often to actually run the expensive check (seconds)
  # 86400 = 24 hours
  minInterval = 86400;

  checkScript = pkgs.writeShellScript "flake-update-check-on-login" ''
    set -euo pipefail

    if [ ! -d "${flakeDir}" ]; then
      exit 0
    fi

    cacheDir="''${XDG_CACHE_HOME:-$HOME/.cache}/nixos-flake-update-check"
    stampFile="$cacheDir/last-check-epoch"
    mkdir -p "$cacheDir"

    now="$(date +%s)"
    last=0
    if [ -f "$stampFile" ]; then
      last="$(cat "$stampFile" || echo 0)"
    fi

    # Throttle: only run once per interval
    if [ $((now - last)) -lt ${toString minInterval} ]; then
      exit 0
    fi
    echo "$now" > "$stampFile"

    tmp="$(mktemp -d)"
    trap 'rm -rf "$tmp"' EXIT

    # Copy the repo to temp so we NEVER touch your working tree / flake.lock
    cp -a "${flakeDir}/." "$tmp/"

    # Update lock ONLY in temp
    ${pkgs.nix}/bin/nix flake update --flake "$tmp" >/dev/null

    if ! cmp -s "${flakeDir}/flake.lock" "$tmp/flake.lock"; then
      # Wait briefly for the user session bus (common race at login)
      for i in $(seq 1 20); do
        if ${pkgs.dbus}/bin/busctl --user status >/dev/null 2>&1; then
          break
        fi
        sleep 0.2
      done

      ${pkgs.libnotify}/bin/notify-send \
        --app-name="NixOS" \
        "Nix flake updates available" \
        "Your inputs have updates. Run: nix flake update (in ${flakeDir})"
    fi
  '';
in
{
  home.packages = [ pkgs.libnotify ];

  systemd.user.services.flake-update-notify = {
    Unit = {
      Description = "Notify if Nix flake inputs have updates (runs on login)";
      # If notifications aren't available yet, it’s still fine — it will just fail to notify.
      # You can add After=graphical-session.target to reduce chances of racing the notification daemon.
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = checkScript;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
