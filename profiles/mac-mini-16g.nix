# profiles/macmini-7-1.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../hosts/mac-mini/configuration.nix
    ../modules/default.nix
    # ../modules/browsers/brave.nix
    # ../modules/virtualization/virtualization.nix
  ];
}
