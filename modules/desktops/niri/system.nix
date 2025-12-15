# modules/desktops/niri/system.nix
{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  programs.xwayland.enable = true;
}
