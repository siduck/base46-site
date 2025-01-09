local o = vim.o

o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

vim.opt.fillchars = { eob = " " }
o.number = true
o.signcolumn = "yes"
o.termguicolors = true

-- put this in your main init.lua file ( before lazy setup )
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

require("nvim-treesitter.configs").setup {
  ensure_installed = {
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
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
  sync_install = true,
}

 require("ibl").setup {
    indent = { char = "│" },
    scope = { char = "│", highlight = "Comment" },
 }
