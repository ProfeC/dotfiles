# modules/system/auto-upgrade.nix
{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkEnableOption mkIf types;

  upgradeScript = pkgs.writeShellScript "auto-upgrade-wrapper" ''
    set -euo pipefail

    # Ensure proper environment
    export PATH="${pkgs.nix}/bin:${pkgs.coreutils}/bin:${pkgs.systemd}/bin:$PATH"
    export NIX_PATH=""

    FLAKE="${config.autoUpgrade.flakePath}"
    MODE="${config.autoUpgrade.mode}"

    # Validate flake path (support flake paths that include `#host` fragment)
    FLAKE_DIR="$(echo "$FLAKE" | cut -d'#' -f1)"
    if ! [ -d "$FLAKE_DIR" ] || ! nix flake metadata "$FLAKE" >/dev/null 2>&1; then
      echo "[auto-upgrade] ERROR: Invalid flake path: $FLAKE"
      ${config.autoUpgrade.failureNotifyScript}
      exit 1
    fi

    # Early exit for "off" mode (though service should be disabled)
    if [ "$MODE" = "off" ]; then
      echo "[auto-upgrade] Mode is 'off' — skipping."
      exit 0
    fi

    # Dry-run mode: simulate without applying
    if [ "${toString config.autoUpgrade.dryRun}" = "true" ]; then
      echo "[auto-upgrade] Dry-run mode: Simulating update…"
      nix flake update "$FLAKE" --dry-run
      nixos-rebuild dry-run --flake "$FLAKE"
      echo "[auto-upgrade] Dry-run complete."
      exit 0
    fi

    echo "[auto-upgrade] Updating flake inputs…"
    nix flake update "$FLAKE"

    echo "[auto-upgrade] Checking if system can build…"
    if ! nixos-rebuild test --flake "$FLAKE"; then
      echo "[auto-upgrade] Build failed — NOT applying."
      ${config.autoUpgrade.failureNotifyScript}
      exit 1
    fi

    echo "[auto-upgrade] Build OK."

    # "check" = fetch + test only
    if [ "$MODE" = "check" ]; then
      echo "[auto-upgrade] Check phase complete — Not applying."
      ${config.autoUpgrade.successNotifyScript}
      exit 0
    fi

    # Apply without reboot
    if [ "$MODE" = "apply" ]; then
      echo "[auto-upgrade] Applying update…"
      nixos-rebuild switch --flake "$FLAKE"
      echo "[auto-upgrade] Update applied successfully."
      ${config.autoUpgrade.successNotifyScript}
      exit 0
    fi

    # Apply with reboot if needed
    if [ "$MODE" = "apply-reboot" ]; then
      echo "[auto-upgrade] Applying update (reboot allowed)…"
      nixos-rebuild switch --flake "$FLAKE"
      echo "[auto-upgrade] Update applied. Checking if reboot is needed…"

      # Check if reboot is required (kernel/initrd mismatch)
      current_kernel="$(readlink /run/current-system/kernel)"
      booted_kernel="$(readlink /run/booted-system/kernel)"
      if [ "$current_kernel" != "$booted_kernel" ]; then
        echo "[auto-upgrade] Reboot required due to kernel change. Rebooting in ${toString config.autoUpgrade.rebootDelay} seconds…"
        sleep "${config.autoUpgrade.rebootDelay}"
        systemctl reboot
      else
        echo "[auto-upgrade] No reboot needed."
      fi
      ${config.autoUpgrade.successNotifyScript}
      exit 0
    fi
  '';
in
{
  options.autoUpgrade = {
    enable = mkEnableOption "NixOS automatic upgrades with safe testing.";

    mode = mkOption {
      type = types.enum [ "off" "check" "apply" "apply-reboot" ];
      default = "check";
      description = ''
        - "off"          → disabled (service won't run)
        - "check"        → update flake, test build, notify only
        - "apply"        → update + apply if build succeeds
        - "apply-reboot" → apply + reboot if kernel/initrd changed
      '';
    };

    flakePath = mkOption {
      type = types.str;
      default = "/etc/nixos";
      description = "Flake used for upgrades. Must be a valid Nix flake directory.";
    };

    schedule = mkOption {
      type = types.str;
      default = "daily";
      description = "When the upgrade job should run (systemd OnCalendar format).";
    };

    dryRun = mkOption {
      type = types.bool;
      default = false;
      description = "If true, simulate updates without applying (overrides mode).";
    };

    rebootDelay = mkOption {
      type = types.int;
      default = 10;
      description = "Seconds to wait before rebooting in 'apply-reboot' mode.";
    };

    requireAC = mkOption {
      type = types.bool;
      default = false;
      description = "Skip upgrades if not on AC power (requires upower).";
    };

    successNotifyScript = mkOption {
      type = types.str;
      default = "${pkgs.coreutils}/bin/true";
      description = "Command to run on successful update/check.";
    };

    failureNotifyScript = mkOption {
      type = types.str;
      default = "${pkgs.coreutils}/bin/true";
      description = "Command to run on update failure.";
    };
  };

  config = mkIf config.autoUpgrade.enable {
  # Only enable service if mode isn't "off"
  systemd.services.auto-upgrade = mkIf (config.autoUpgrade.mode != "off") {
    description = "NixOS auto-upgrade with test step";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemd-cat --identifier=auto-upgrade ${upgradeScript}";
      # Skip if on battery (if required)
      ConditionACPower = mkIf config.autoUpgrade.requireAC "true";

      # Hardening: keep some protections but allow necessary writes for Nix operations
      NoNewPrivileges = true;
      ProtectSystem = "full";
      ProtectHome = true;

      # Allow writing to Nix and runtime paths that rebuild/switch need
      ReadWritePaths = [
        "/nix/store"
        "/nix/var"
        "/run"
        "/etc/systemd/system"
        "/var/lib/nixos"
      ];
    };
  };

    systemd.timers.auto-upgrade = mkIf (config.autoUpgrade.mode != "off") {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = config.autoUpgrade.schedule;
        Persistent = true;
      };
    };

    # Ensure dependencies
    environment.systemPackages = [ pkgs.nix pkgs.coreutils pkgs.systemd ];
  };
}
