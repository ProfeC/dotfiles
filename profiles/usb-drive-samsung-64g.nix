# profiles/usb-drive-samsung-64g.nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../nixosModules/default.nix
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
