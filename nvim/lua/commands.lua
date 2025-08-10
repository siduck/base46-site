vim.api.nvim_create_user_command("Vihtml", function()
  require "vihtml"
end, {})

vim.api.nvim_create_user_command("TSInstallParsers", function()
  local langs = {
    "lua",
    "rust",
    "c",
    "go",
    "elixir",
    "haskell",
    "python",
    "ruby",
    "javascript",
    "bash",
    "typescript",
  }

  require("nvim-treesitter").install(langs):wait()
end, {})
