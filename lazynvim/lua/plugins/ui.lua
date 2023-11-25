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
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
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

  -- filename
  {
    "b1o/incline.nvim",
    event = "BufReadPre",
    priority = 1201,
    config = function()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#BD94F9", guifg = "#21222C" },
            InclineNormalNC = { guifg = "#F9F8F2", guibg = "#3E4452" },
          },
        },
        window = { margin = { vertical = 1, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
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
