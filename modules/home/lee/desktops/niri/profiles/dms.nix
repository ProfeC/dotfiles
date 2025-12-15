# modules/home/lee/desktops/niri/profile-dms.nix
# dms => Dank Material Shell
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dank-material-shell
    waybar
    fuzzel
  ];
}
