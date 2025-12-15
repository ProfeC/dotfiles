# modules/home/lee/desktops/niri/default.nix
{ config, pkgs. lib, ... }:

{
  imports = [
    ./packages.nix
    ./profiles/legos.nix
    ./profiles/dms.nix
    ./profiles/noctalia.nix
  ];

  home.file = {
    ".config/niri/legos.kdl".source = ./profiles/legos.kdl;
    # ".config/niri/dms.kdl".source = ./profiles/dms.kdl;
    # ".config/niri/noctalia.kdl".source = ./profiles/noctalia.kdl;
  };
}
