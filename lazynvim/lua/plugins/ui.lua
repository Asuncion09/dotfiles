return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })

      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1001,
    },
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        -- mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- LuaSnippets
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    wants = "friendly-snippets",
    requires = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip").filetype_extend("javascript", { "html" })
      require("luasnip").filetype_extend("javascriptreact", { "html" })
      require("luasnip").filetype_extend("javascriptreact", { "javascript" })
      require("luasnip").filetype_extend("typescriptreact", { "html" })
      require("luasnip").filetype_extend("html", { "javascript" })
      require("luasnip").filetype_extend("handlebars", { "html" })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- globalstatus = false,
        theme = "auto",
      },
    },
  },

  -- Logo
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
      ██████╗ ██╗      █████╗ ███████╗██╗   ██╗███╗   ██╗ ██████╗██╗ ██████╗ ███╗   ██╗
      ██╔══██╗██║     ██╔══██╗██╔════╝██║   ██║████╗  ██║██╔════╝██║██╔═══██╗████╗  ██║
      ██║  ██║██║     ███████║███████╗██║   ██║██╔██╗ ██║██║     ██║██║   ██║██╔██╗ ██║
      ██║  ██║██║     ██╔══██║╚════██║██║   ██║██║╚██╗██║██║     ██║██║   ██║██║╚██╗██║
      ██████╔╝███████╗██║  ██║███████║╚██████╔╝██║ ╚████║╚██████╗██║╚██████╔╝██║ ╚████║
      ╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝
    ]]

      logo = string.rep("\n", 6) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
