# modules/home/lee/neovim.nix
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.editor.neovim;
in
{
  options.editor.neovim = {
    enable = mkEnableOption "Enable Neovim configuration for Home Manage";
  };

  config = mkIf cfg.enable {
   home.packages = with pkgs; [
      vimPlugins.vim-plug
    ];

    home.file.".config/nvim/init.lua".text = ''
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

      -- Set <Space> as leader
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Plugins
      require("lazy").setup({
        { "navarasu/onedark.nvim" },
        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
        { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        { "nvim-lualine/lualine.nvim" },
        { "lewis6991/gitsigns.nvim" },
        { "folke/which-key.nvim" },
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
        { "saadparwaiz1/cmp_luasnip" },
      }, {
        install = { missing = true },
        ui = { border = "rounded" },
      })

      -- Theme
      require("onedark").setup { style = "warm" }
      require("onedark").load()

      -- Treesitter
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- Telescope keymaps
      vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live grep" })

      -- Lualine
      require("lualine").setup()

      -- Gitsigns
      require("gitsigns").setup()

      -- which-key
      require("which-key").setup()
      require("which-key").register({
        f = { name = "+file" },
        g = { name = "+git" },
        l = { name = "+lsp" },
      }, { prefix = "<leader>" })

      -- Mason (LSP installer)
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls", "pyright", "nil_ls", "html", "cssls", "tsserver", "lemminx", "phpactor",
        },
      }

      -- nvim-cmp
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })

      -- LSP config
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      for _, lsp in ipairs({ "lua_ls", "pyright", "nil_ls", "html", "cssls", "tsserver", "lemminx", "phpactor" }) do
        lspconfig[lsp].setup { capabilities = capabilities }
      end

      -- Editor basics
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

      -- Search
      vim.o.ignorecase = true
      vim.o.smartcase = true
      vim.o.hlsearch = true
      vim.o.incsearch = true

      -- Netrw
      vim.g.netrw_banner = 0
      vim.g.netrw_liststyle = 3
      vim.g.netrw_browse_split = 4
      vim.g.netrw_altv = 1
      vim.g.netrw_winsize = 25
    '';
  };
}
