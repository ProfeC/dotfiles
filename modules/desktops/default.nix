# modules/desktops/default.nix
{ inputs, ... }:
{
  imports = [
    ./kde-plasma.nix
    ./niri/system.nix
    # ./niri/sessions.nix
  ];
}
