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
    ../modules/default.nix
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
