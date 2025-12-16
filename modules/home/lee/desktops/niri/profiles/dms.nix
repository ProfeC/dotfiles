# modules/home/lee/desktops/niri/profile-dms.nix
# dms => Dank Material Shell
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    fuzzel
  ];

  programs.waybar.enable = true;

}
