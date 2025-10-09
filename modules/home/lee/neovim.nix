# modules/home/lee/neovim.nix
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.editor.neovim;
in {
  options.editor.neovim = {
    enable = mkEnableOption "Enable Neovim configuration for Home Manager";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      # You can also set `extraPackages` here if you need external tools
      # that plugins/LSPs rely on (ripgrep, fd, etc.)
      extraPackages = with pkgs; [
        ripgrep
        fd
        tree-sitter
        nodejs
        python3
      ];
    };

    # Drop your init.lua in ~/.config/nvim/init.lua
    home.file.".config/nvim/init.lua".source = ./config/nvim/init.lua;
    home.file.".config/nvim/lua".source = ./config/nvim/lua;
  };
}
