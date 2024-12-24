local utils = require "vihtml.utils"
local M = {}

M.write_file = function(path, str)
  local file = io.open(path, "wb")

  if file then
    file:write(str)
    file:close()
  end
end

M.get_theme_list = function()
  local list = {}

  for _, v in ipairs(require "themelist") do
    list = vim.list_extend(list, v.variants)
  end

  return list
end

M.base46_themes_html = function()
  -- local cwd = vim.uv.cwd()
  -- local html_path = cwd .. "/src/lib/vihtml/"
  -- local css_path = cwd .. "/src/lib/vicss/"
  --
  -- local list = M.get_theme_list()
  --
  -- for _, v in ipairs(list) do
  --   vim.cmd("colorscheme " .. v)
  --
  --   local code = utils.win_to_html(v)
  --
  --   M.write_file(html_path .. v .. ".svelte", code.html)
  --   M.write_file(css_path .. v .. ".css", code.css)
  -- end
  --
  -- local theme_json_path = cwd .. "/src/lib/themes.json"
  -- local themes = require "themelist"
  --
  -- local json = vim.json.encode(themes)
  -- M.write_file(theme_json_path, json)
end

M.base46_themes_html()
