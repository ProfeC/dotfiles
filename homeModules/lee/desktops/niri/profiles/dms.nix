# modules/home/lee/desktops/niri/profile-dms.nix
# dms => Dank Material Shell
{ pkgs, inputs, ... }:

{
  imports = [
    # Provides config.lib.niri.actions (what DMS expects)
    inputs.niri.homeModules.niri

    # DMS Modules
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  programs.dankMaterialShell = {
    enable = true;

    # Optional, but helpful for keyboard-first Niri evaluation
    niri = {
      enableKeybinds = true;
      enableSpawn = true; # auto-start DMS with niri
    };
  };

  # DMS replaces waybar/mako/fuzzel in its intended setup
  programs.waybar.enable = false;

  # Keep this only if you want Mod+D -> fuzzel consistent while evaluating
  # (DMS has its own launcher)
  # home.packages = [ pkgs.fuzzel ];
}
