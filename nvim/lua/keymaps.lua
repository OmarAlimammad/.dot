vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", ":silent w<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":q!<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", ":%y+<CR>", { silent = true })
