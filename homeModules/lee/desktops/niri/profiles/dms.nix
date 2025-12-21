# modules/home/lee/desktops/niri/profile-dms.nix
# dms => Dank Material Shell
{ pkgs, ... }:
{
  home.packages = [
    dms
    fuzzel  # keep Mod+D consistent while evaluating
  ];

  programs.waybar.enable = false;
}
