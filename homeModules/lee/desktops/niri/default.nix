# modules/home/lee/desktops/niri/default.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ./packages.nix
    ./profiles/base.nix
    ./profiles/dms.nix
    ./profiles/noctalia.nix
  ];

  home.file = {
    ".config/niri/base.kdl".source = ./configs/base.kdl;
    ".config/niri/dms.kdl".source = ./configs/dms.kdl;
    ".config/niri/noctalia.kdl".source = ./configs/noctalia.kdl;
  };
}
