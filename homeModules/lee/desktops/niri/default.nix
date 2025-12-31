# modules/home/lee/desktops/niri/default.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ./packages.nix
  ];

  home.file.".config/niri/base.kdl".source = ./configs/base.kdl;
  home.file.".config/niri/config.kdl".source = ./configs/noctalia.kdl;
}
