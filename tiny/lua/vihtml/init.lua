local utils = require "vihtml.utils"
local M = {}

local themelist = utils.get_themedata()

M.theme_to_html = function(name, cwd)
  vim.cmd("colorscheme " .. name)

  local html_path = cwd .. "/src/lib/vihtml/" .. name .. ".svelte"
  local css_path = cwd .. "/src/lib/vicss/" .. name .. ".css"
  local code = utils.win_to_html(name)

  utils.write_file(html_path, code.html)
  utils.write_file(css_path, code.css)
end

M.base46_themes_html = function()
  local cwd = vim.uv.cwd()

  for _, v in ipairs(themelist) do
    for _, name in ipairs(v.variants) do
      M.theme_to_html(name, cwd)
    end
  end

  local themelist_json = vim.json.encode(themelist)
  utils.write_file(cwd .. "/src/data.json", themelist_json)
end

vim.cmd("e" .. vim.fn.stdpath "config" .. "/init.lua") 

M.base46_themes_html()
