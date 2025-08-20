# profiles/macmini-7-1.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../hosts/mac-mini/configuration.nix
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
