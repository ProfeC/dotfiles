# profiles/wsl2.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../hosts/wsl2/configuration.nix
    ../modules/common.nix
    # ../modules/brave.nix
    ../modules/firefox.nix
    ../modules/x11.nix
  ];
}
