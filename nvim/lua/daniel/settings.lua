
vim.g.mapleader = " "
vim.opt.backup = false
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.number = true

-- Indentacion de 4 espacios
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0

-- external copy
vim.g.clipboard = {
	name = 'xclip',
	copy = {
		['+'] = 'xclip -selection clipboard',
		['*'] = 'xclip -selection clipboard'
	},
	paste = {
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection clipboard -o',
   },
   cache_enabled = 1,
}

-- terminal
vim.opt.splitbelow = true
vim.opt.splitright = true

