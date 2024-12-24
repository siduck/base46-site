require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "rust", "c", "go", "elixir", "haskell" , 'python'},

  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
}
