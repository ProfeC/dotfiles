# profiles/shu-t14s.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../hosts/shu-laptop/configuration.nix
    ../modules/system/boot-loader.nix
    ../modules/common.nix
    ../modules/system/audio-pipewire.nix
    ../modules/system/bluetooth.nix
    # ../modules/browsers/brave.nix
    ../modules/browsers/firefox.nix
    ../modules/desktops/kde-plasma.nix
    # ../modules/virtualization/virtualization.nix
    ../modules/system/x11.nix
  ];
}
