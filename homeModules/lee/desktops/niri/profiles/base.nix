# modules/home/lee/desktops/niri/profile-base.nix
{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    fuzzel        # or alternatives (rofi?) later
  ];

  programs.waybar.enable = lib.mkDefault true;
  services.mako.enable = lib.mkDefault true;
}
