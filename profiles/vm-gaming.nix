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
    ../nixosModules/default.nix
  ];
}
