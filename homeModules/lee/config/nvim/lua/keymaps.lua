local telescope = require("telescope.builtin")

-- Telescope
vim.keymap.set("n", "<C-p>", telescope.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
