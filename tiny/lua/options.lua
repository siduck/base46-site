local o = vim.o

o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

vim.opt.fillchars = { eob = " " }
o.mouse = "a"

o.number = true
o.signcolumn = "yes"
o.termguicolors = true

vim.api.nvim_set_hl(0, "IndentLine", { link = "Comment" })
