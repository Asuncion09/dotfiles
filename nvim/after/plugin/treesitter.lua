require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help", "java", "python", "javascript", "php", "html", "css", "markdown", "bash"},

  sync_install = true,
  auto_install = true,


  highlight ={
    enable = true,
    additional_vim_regex_highlighting = true,

  },
}
