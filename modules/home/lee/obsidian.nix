# modules/home/lee/obsidian.nix
{ config, pkgs, lib, ... }:

let
  # Define any vault aliases here
  vaults = {
    # personal = "/home/lee/Obsidian/Personal";
    # work     = "/home/lee/Obsidian/Work";
  };
in {
  options.editor.obsidian = {
    enable = lib.mkEnableOption "Enable Obsidian markdown editor with Home Manager";
  };

  config = lib.mkIf config.editor.obsidian.enable {

    # System-wide package
    home.packages = [ pkgs.obsidian ];

    ########################
    # User Config
    ########################
    # Map the main app config files
    # home.file.".config/obsidian/app.json".source = /home/lee/.config/obsidian/app.json;
    # home.file.".config/obsidian/workspace.json".source = /home/lee/.config/obsidian/workspace.json;
    # home.file.".config/obsidian/plugins".source = /home/lee/.config/obsidian/plugins;
    home.file.".config/obsidian/Preferences".text = ''
    {"browser":{"enable_spellchecking":true},"partition":{"per_host_zoom_levels":{"5758236113743254910":{},"9337329102044273761" │ :{}}},"spellcheck":{"dictionaries":["en-US"],"dictionary":""}}
    '';

    ########################
    # Shell Aliases for Vaults
    ########################
    programs.bash.shellAliases = lib.mkMerge (builtins.mapAttrs (_: path: {
      inherit path;
      value = "obsidian --vault ${path}";
    }) vaults);

    ########################
    # Optional: .desktop entry
    ########################
    xdg.desktopEntries.obsidian = {
      name = "Obsidian";
      exec = "${pkgs.obsidian}/bin/obsidian";
      icon = "obsidian";
      type = "Application";
      categories = [ "Utility" "Office" ];
    };
  };
}
