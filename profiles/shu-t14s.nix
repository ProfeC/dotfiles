# profiles/shu-t14s.nix
{ config, pkgs, lib, inputs, ... }:

{
  # Import the machine-specific configuration
  imports = [
    ../hosts/shu-laptop/configuration.nix   # Now receives `inputs` from the profile
    ../modules/system/boot-loader.nix
    ../modules/common.nix
    ../modules/system/audio-pipewire.nix
    ../modules/system/bluetooth.nix
    ../modules/browsers/firefox.nix
    ../modules/browsers/vivaldi.nix
    ../modules/desktops/kde-plasma.nix
    ../modules/system/x11.nix
    ../modules/development/vscodium.nix
    ../modules/editors/nano.nix
    ../modules/editors/neovim.nix
  ];

  development.vscodium.enable = true;
  editor.nano.enable = true;
  editor.neovim.enable = true;
}
