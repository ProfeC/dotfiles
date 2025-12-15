# modules/home/lee/desktops/niri/profile-legos.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    fuzzel        # or alternatives (rofi?) later
  ];

  programs.waybar.enable = true;
  services.mako.enable = true;
}
