vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require('bufferline').setup({
  options = {
    mode = 'buffers',
    offsets = {
      {filetype = 'NvimTree'}
    },
  },
 
})

vim.cmd[[
	nnoremap <silent><TAB> :BufferLineCycleNext<CR>
	nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
]]
