# home/lee/niri.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wezterm
    xwayland-satellite
  ];

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
