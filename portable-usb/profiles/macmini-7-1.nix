{ config, pkgs, ... }:

{
  networking.hostName = "macmini-nixos";
  programs.steam.enable = true;
}
