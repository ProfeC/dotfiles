{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myNeovim;
in
{
  options.myNeovim = {
    enable = mkEnableOption "Enable customized Neovim editor";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim
    ];

    # Drop a minimal init.vim into /etc/xdg/nvim
    environment.etc."xdg/nvim/init.vim".text = ''
      " Basic comfort settings (Nano-like)
      set number             " line numbers
      set relativenumber     " relative numbers (easier motions)
      set cursorline         " highlight current line
      set wrap               " soft wrap
      set linebreak          " wrap without breaking words
      syntax on              " syntax highlighting

      " UI tweaks
      set showcmd            " show incomplete commands
      set showmode           " show mode (INSERT, NORMAL, etc.)
      set ruler              " show cursor position
      set termguicolors      " better colors

      " Search
      set ignorecase
      set smartcase
      set hlsearch
      set incsearch

      " Tabs/spaces
      set expandtab
      set shiftwidth=2
      set tabstop=2

      " Theme (pick one, or install a plugin later)
      let g:onedark_config = {
          \ 'style': 'warm',
      }
      colorscheme onedark	" https://github.com/navarasu/onedark.nvim

      " File browser: use built-in netrw
      let g:netrw_banner = 0
      let g:netrw_liststyle = 3
      let g:netrw_browse_split = 4
      let g:netrw_altv = 1
      let g:netrw_winsize = 25
    '';
  };
}
