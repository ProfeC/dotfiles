# profiles/macmini-7-1.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../hosts/mac-mini/configuration.nix
    ../nixosModules/default.nix
  ];
}
