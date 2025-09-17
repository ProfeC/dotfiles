# profiles/usb-drive-samsung-64g.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../modules/system/boot-loader.nix
    ../modules/common.nix
    ../modules/system/audio-pipewire.nix
    ../modules/system/bluetooth.nix
    # ../modules/browsers/brave.nix
    ../modules/browsers/firefox.nix
    ../modules/desktops/kde-plasma.nix
    # ../modules/virtualization/virtualization.nix
    ../modules/system/x11.nix
    ../modules/development/nano.nix
    ../modules/development/neovim.nix
  ];

  # development.vscodium.enable = true;
  myNano.enable = true;
  myNeovim.enable = true;

  # 👇 required for flake check / evaluation
  system.stateVersion = "25.05";

  # 👇 minimal fake root — swap with actual UUID if/when you boot from this
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
  };
}
