# modules/desktops/default.nix
{
  imports = [
    ./kde-plasma.nix
    ./niri/system.nix
    ./niri/sessions.nix
  ];
}
