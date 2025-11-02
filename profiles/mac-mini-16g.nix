# profiles/macmini-7-1.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../hosts/mac-mini/configuration.nix
    # ../modules/browsers/brave.nix
    ../modules/browsers/firefox.nix
    ../modules/browsers/vivaldi.nix
    ../modules/common.nix
    ../modules/desktops/kde-plasma.nix
    ../modules/system/audio-pipewire.nix
    ../modules/system/bluetooth.nix
    ../modules/system/fuse.nix
    ../modules/system/x11.nix
    # ../modules/virtualization/virtualization.nix
    ../modules/system/tailscale.nix
  ];
}
