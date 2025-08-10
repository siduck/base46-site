require "globals"
require "commands"

local plugins_path = vim.fn.stdpath "data" .. "/site/pack/plugins/start/"

local plugins = {
  "nvim-treesitter/nvim-treesitter",
  "nvchad/base46",
  "nvim-lua/plenary.nvim",
  "lukas-reineke/indent-blankline.nvim",
}

local clone_repo = function(repo, branch)
  local name = repo:match "([^/]+)$"
  local install_path = plugins_path .. name

  repo = "https://github.com/" .. repo .. ".git"

  local args = { "git", "clone", "--depth", "1", repo, install_path }

  if branch then
    table.insert(args, "--branch")
    table.insert(args, branch)
  end

  vim.fn.system(args)

  vim.notify("installed " .. name)
end

if not vim.loop.fs_stat(plugins_path) then
  vim.fn.mkdir(plugins_path, "p")

  for i, repo in ipairs(plugins) do
    clone_repo(repo, i == 1 and "main" or nil)
  end

  vim.cmd "packadd nvim-treesitter"
  vim.cmd "packadd base46"
  vim.cmd "packadd plenary.nvim"

  vim.cmd "TSInstallParsers"

  require("base46").compile()
  vim.notify "base46 hlgroups compiled"
end

require("nvim-treesitter").setup {}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

pcall(function()
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

require("ibl").setup {
  indent = { char = "│" },
  scope = { char = "│", highlight = "Comment" },
}
