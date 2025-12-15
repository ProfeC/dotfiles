# modules/desktops/niri/sessions.nix
{ pkgs, ... }:

{
  services.displayManager.extraSessionFilePackages = [
    (pkgs.writeTextDir "share/wayland-sessions/niri-legos.desktop" ''
      [Desktop Entry]
      Name=Niri (Legos)
      Comment=Niri + Waybar + Fuzzel
      Exec=env NIRI_PROFILE=legos niri
      Type=Application
    '')

    (pkgs.writeTextDir "share/wayland-sessions/niri-dms.desktop" ''
      [Desktop Entry]
      Name=Niri (DankMaterialShell)
      Comment=Niri + DMS
      Exec=env NIRI_PROFILE=dms niri
      Type=Application
    '')

    (pkgs.writeTextDir "share/wayland-sessions/niri-noctalia.desktop" ''
      [Desktop Entry]
      Name=Niri (Noctalia)
      Comment=Niri + Noctalia Shell
      Exec=env NIRI_PROFILE=noctalia niri
      Type=Application
    '')
  ];
}
