# modules/home/lee/wezterm.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  wezterm_config = builtins.readFile ./config/wezterm/wezterm-extra.lua;
in {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = wezterm_config;
  };
}
