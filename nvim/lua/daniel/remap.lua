
local opts = { noremap = true, silent = true  }

vim.keymap.set("i", "ññ", "<ESC>", opts)
vim.keymap.set("n", "<leader>V", ":vsplit<CR>", opts)

-- Crear search highlight
vim.keymap.set("n", "<esc>", ":noh<return><esc>", opts)


-- Bufferline

