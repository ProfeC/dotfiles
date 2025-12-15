# modules/home/lee/desktops/niri/profile-nocalia.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    noctalia
  ];
}
