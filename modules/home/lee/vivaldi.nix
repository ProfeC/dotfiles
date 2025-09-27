# modules/home/lee/vivaldi.nix
{ config, pkgs, lib, ... }:

let
  vivaldiTuned = pkgs.writeShellScriptBin "vivaldi-tuned" ''
      exec ${pkgs.vivaldi}/bin/vivaldi \
        --process-per-site \
        # --disable-renderer-backgrounding \
        --disable-background-timer-throttling \
        --disable-backgrounding-occluded-windows \
        --enable-features=VaapiVideoDecoder,CanvasOopRasterization,AcceleratedVideoDecodeLinuxGL \
        --enable-gpu-rasterization \
        --enable-zero-copy \
        --use-gl=desktop \
        --ignore-gpu-blocklist \
        --ozone-platform=wayland \
        --disable-background-networking \
        --disable-breakpad \
        --disable-domain-reliability \
        --no-first-run \
        --enable-features=WebUIDarkMode \
        --use-system-theme \
        "$@"
    '';
in {
  home.packages = [ vivaldiTuned ];

  ########################################
  ## Extension policy (system-wide)
  ## NOTE: switch to xdg.configFile in HM later
  ########################################
  xdg.configFile."vivaldi/policies/managed/extensions.json".text = ''
    {
      "ExtensionInstallForcelist": [
        "nngceckbapebfimnlniiiahkandclblb",  // Bitwarden
        "bfidboloedlamgdmenmlbipfnccokknp"   // PureVPN
      ]
    }
  '';

  ########################################
  ## Aliases for multiple profiles
  ## NOTE: migrate to programs.bash.shellAliases in HM
  ########################################
  programs.bash.shellAliases = {
    vivaldi-default = "vivaldi --user-data-dir=$HOME/.config/vivaldi-default --use-system-theme";
    vivaldi = "vivaldi-tuned";
  };

  ########################################
  ## Patch .desktop file(s)
  ########################################
  xdg.desktopEntries.vivaldi-tuned = {
    name = "Vivaldi (Tuned)";
    exec = "${vivaldiTuned}";
    icon = "vivaldi";
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };

  xdg.desktopEntries.vivaldi-default = {
    name = "Vivaldi (Default)";
    exec = "${pkgs.vivaldi}/bin/vivaldi";
    icon = "vivaldi";
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };
}
