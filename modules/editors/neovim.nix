# modules/editors/neovim.nix
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.editor.neovim;
in
{
  options.editor.neovim = {
    enable = mkEnableOption "Enable customized Neovim editor";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim
      vimPlugins.vim-plug
    ];
  };
}
