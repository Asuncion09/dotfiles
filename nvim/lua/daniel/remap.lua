
local opts = { noremap = true, silent = true  }

vim.keymap.set("i", "ññ", "<ESC>", opts)
vim.keymap.set("n", "<leader>V", ":vsplit<CR>", opts)

-- Crear search highlight
vim.keymap.set("n", "<esc>", ":noh<return><esc>", opts)


-- Bufferline
vim.keymap.set("n", "<leader>D", ":wa<CR>:bd!<CR>", opts)

-- Terminal
vim.keymap.set("n", "<c-t>", ":split<CR>:ter<CR>:resize 15<CR>", opts)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
