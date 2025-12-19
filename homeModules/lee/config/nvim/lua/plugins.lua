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

-- Lualine
require("lualine").setup()

-- Gitsigns
require("gitsigns").setup()

-- Which-key
require("which-key").setup()
require("which-key").register({
  f = { name = "+file" },
  g = { name = "+git" },
  l = { name = "+lsp" },
}, { prefix = "<leader>" })
