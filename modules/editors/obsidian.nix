{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.editor.obsidian;
in
{
  options.editor.obsidian = {
    enable = mkEnableOption "Enable Obsidian markdown editor";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];

    # environment.etc."obsidianrc".text = ''
    # '';
  };
}
