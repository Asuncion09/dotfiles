return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "bash",
        "java",
        "htmldjango",
        "latex",
        "glimmer",
        "sxhkdrc",
        "astro",
        "cmake",
        "gitignore",
        "http",
        "scss",
        "sql",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      --MDX
      vim.filetype.add({
        extensioon = {
          mdx = "mdx",
        },
        vim.treesitter.language.register("markdown", "mdx"),
      })
    end,
  },
}
