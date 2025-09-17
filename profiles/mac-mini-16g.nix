# profiles/macmini-7-1.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../hosts/mac-mini/configuration.nix
    ../modules/system/boot-loader.nix
    ../modules/common.nix
    ../modules/system/audio-pipewire.nix
    ../modules/system/bluetooth.nix
    # ../modules/browsers/brave.nix
    ../modules/browsers/firefox.nix
    ../modules/system/fuse.nix
    ../modules/browsers/vivaldi.nix
    ../modules/desktops/kde-plasma.nix
    # ../modules/virtualization/virtualization.nix
    ../modules/system/x11.nix
    ../modules/editors/nano.nix
    ../modules/editors/neovim.nix
    ../modules/development/vscodium.nix
  ];

  development.vscodium.enable = true;
  editors.nano.enable = true;
  editors.neovim.enable = true;
}
