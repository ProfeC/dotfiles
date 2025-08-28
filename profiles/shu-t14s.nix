# profiles/shu-t14s.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../hosts/shu-laptop/configuration.nix
    ../modules/common.nix
    ../modules/audio-pipewire.nix
    ../modules/bluetooth.nix
    # ../modules/brave.nix
    ../modules/firefox.nix
    ../modules/kde-plasma.nix
    # ../modules/virtualization.nix
    ../modules/x11.nix
  ];
}
