return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "python-lsp-server",
        "prettier",
        "css-lsp",
        "html-lsp",
        "black",
        "tailwindcss-language-server",
        "shellcheck",
      })
    end,
  },
}
