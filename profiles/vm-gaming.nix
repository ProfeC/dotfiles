# profiles/shu-t14s.nix
{
  config,
  pkgs,
  lib,
  inputs,
  home-manager,
  ...
}: {
  # Import the machine-specific configuration
  imports = [
    ../hosts/virtual-machines/gaming/configuration.nix # Now receives `inputs` from the profile
    ../modules/browsers/firefox.nix
    ../modules/browsers/vivaldi.nix
    ../modules/common.nix
    ../modules/desktops/kde-plasma.nix
    ../modules/gaming/steam.nix
    ../modules/system/audio-pipewire.nix
    ../modules/system/bluetooth.nix
    ../modules/system/boot-loader.nix
    ../modules/system/auto-upgrade.nix
    ../modules/system/x11.nix
    ../modules/system/tailscale.nix
  ];

  # Auto Updater
  autoUpgrade = {
    enable = false;
    mode = "check";
    flakePath = "/home/lee/etc/nixos#vm-gaming";
    dryRun = true;
    requireAC = true;
    rebootDelay = 13;
  };
}
