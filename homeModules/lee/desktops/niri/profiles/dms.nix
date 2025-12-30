# modules/home/lee/desktops/niri/profile-dms.nix
# dms => Dank Material Shell
{ pkgs, inputs, ... }:

{
  # Import the external homeModules from your flake inputs
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell  # DMS module
    inputs.niri.homeModules.niri  # Niri module
  ];

  # Enable Niri (required for DMS to work)
  programs.niri.enable = true;

  # Enable DMS with your desired options
  programs.dankMaterialShell = {
    enable = true;

    # Optional, but helpful for keyboard-first Niri evaluation
    niri = {
      enableKeybinds = true;
      enableSpawn = true;  # Auto-start DMS with Niri
    };
  };

  # DMS replaces waybar/mako/fuzzel in its intended setup
  programs.waybar.enable = false;

  # Keep this only if you want Mod+D -> fuzzel consistent while evaluating
  # (DMS has its own launcher)
  home.packages = [ pkgs.fuzzel ];
}
