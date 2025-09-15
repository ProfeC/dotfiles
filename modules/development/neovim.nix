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
      git
      curl
    ];

    # System-wide Neovim config: basic editor defaults
    environment.etc."xdg/nvim/init.lua".text = ''
      -- Editor basics (Nano-like defaults)
      vim.o.number = true
      vim.o.relativenumber = true
      vim.o.cursorline = true
      vim.o.wrap = true
      vim.o.linebreak = true
      vim.o.expandtab = true
      vim.o.shiftwidth = 2
      vim.o.tabstop = 2
      vim.o.termguicolors = true
      vim.o.showcmd = true
      vim.o.showmode = true
      vim.o.ruler = true

      -- Search improvements
      vim.o.ignorecase = true
      vim.o.smartcase = true
      vim.o.hlsearch = true
      vim.o.incsearch = true

      -- Built-in file browser (netrw)
      vim.g.netrw_banner = 0
      vim.g.netrw_liststyle = 3
      vim.g.netrw_browse_split = 4
      vim.g.netrw_altv = 1
      vim.g.netrw_winsize = 25
    '';

    # Drop a helper script to install lazy.nvim + Onedark Warm for each user
    environment.etc."profile.d/nvim-theme.sh".text = ''
      #!/usr/bin/env bash
      # Only run if user has no ~/.config/nvim/init.lua
      if [ ! -f "$HOME/.config/nvim/init.lua" ]; then
        mkdir -p "$HOME/.config/nvim"
        cat <<'EOF' > "$HOME/.config/nvim/init.lua"
        -- Bootstrap lazy.nvim
        local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        if not vim.loop.fs_stat(lazypath) then
          vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
          })
        end
        vim.opt.rtp:prepend(lazypath)

        local lazy = require("lazy")

        -- Plugins
        lazy.setup({
          { "navarasu/onedark.nvim" }
        })

        -- Force install plugins if missing
        lazy.sync()

        -- Onedark warm theme
        require('onedark').setup { style = 'warm' }
        require('onedark').load()

        -- Include system-wide defaults
        local sys_defaults = '/etc/xdg/nvim/init.lua'
        if vim.loop.fs_stat(sys_defaults) then
          dofile(sys_defaults)
        end
EOF
      fi
    '';
  };
}
