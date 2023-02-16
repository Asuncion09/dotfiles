
return require('packer').startup(function(use)
-- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use({"catppuccin/nvim", as = "catppuccin"})
  use({"folke/tokyonight.nvim", as = "tokyonight"})
  use({
  	"nvim-telescope/telescope.nvim",
	tag = "0.1.0",
	requires = { { "nvim-lua/plenary.nvim" } },

  	})
  use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
  use {
 	 'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
	    -- LSP Support
	    {'neovim/nvim-lspconfig'},             -- Required
	    {'williamboman/mason.nvim'},           -- Optional
	    {'williamboman/mason-lspconfig.nvim'}, -- Optional

	    -- Autocompletion
	    {'hrsh7th/nvim-cmp'},         -- Required
	    {'hrsh7th/cmp-nvim-lsp'},     -- Required
	    {'hrsh7th/cmp-buffer'},       -- Optional
	    {'hrsh7th/cmp-path'},         -- Optional
	    {'saadparwaiz1/cmp_luasnip'}, -- Optional
	    {'hrsh7th/cmp-nvim-lua'},     -- Optional

	    -- Snippets
	    {'L3MON4D3/LuaSnip'},             -- Required
	    {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

  use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- using packer.nvim
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
 
  use "lukas-reineke/indent-blankline.nvim"

  use {
      'nvim-tree/nvim-tree.lua',
      requires = {
          'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use 'm4xshen/autoclose.nvim'

  use {
	'barrett-ruth/live-server.nvim',
	build = 'yarn global add live-server',
	config = true
  }

  use 'alvan/vim-closetag'
  use "savq/melange-nvim"
  use "EdenEast/nightfox.nvim"

 use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
 })

 use 'nvim-tree/nvim-web-devicons'

 use 'tanvirtin/monokai.nvim'
-- use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }

 use 'Mofiqul/dracula.nvim'
 use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
 }




end)

