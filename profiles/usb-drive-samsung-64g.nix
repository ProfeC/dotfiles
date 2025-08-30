# profiles/macmini-7-1.nix
{ config, pkgs, lib, ... }:
{
  imports = [
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
