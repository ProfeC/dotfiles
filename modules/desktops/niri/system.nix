# modules/desktops/niri/system.nix
{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  # programs.dankMaterialShell = {
  #   enable = true;
  #   niri = {
  #     enableKeybinds = true;   # Automatic keybinding configuration
  #     enableSpawn = true;      # Auto-start DMS with niri
  #   };
  # };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  programs.xwayland.enable = true;
}
