# profiles/shu-t14s.nix
{ config, pkgs, lib, inputs, home-manager, ... }:

{
  # Import the machine-specific configuration
  imports = [
    ../hosts/shu-laptop/configuration.nix   # Now receives `inputs` from the profile
    ../modules/browsers/firefox.nix
    ../modules/browsers/vivaldi.nix
    ../modules/common.nix
    ../modules/desktops/kde-plasma.nix
    ../modules/development/vscodium.nix
    ../modules/editors/nano.nix
    ../modules/editors/neovim.nix
    ../modules/editors/obsidian.nix
    ../modules/system/audio-pipewire.nix
    ../modules/system/bluetooth.nix
    ../modules/system/boot-loader.nix
    ../modules/system/x11.nix
  ];

  development.vscodium.enable = true;
  editor.nano.enable = true;
  editor.neovim.enable = true;
  editor.obsidian.enable = true;
}
