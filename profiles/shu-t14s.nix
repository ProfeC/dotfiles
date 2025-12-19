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
    ../hosts/shu-laptop/configuration.nix # Now receives `inputs` from the profile
    ../modules/default.nix
  ];
}
