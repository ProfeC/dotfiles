# modules/home/lee/neovim.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    neovim
    vimPlugins.vim-plug
    ripgrep
    fd
    tree-sitter
    nodejs
    python3
  ];

  # Drop your init.lua in ~/.config/nvim/init.lua
  home.file.".config/nvim/init.lua".source = ../config/nvim/init.lua;
  home.file.".config/nvim/lua".source = ../config/nvim/lua;
}
