require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "rust", "c", "go", "elixir", "haskell", "python", "ruby", 'javascript', 'bash' },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
  sync_install = true,
}
