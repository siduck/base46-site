local utils = require "vihtml.utils"
local M = {}

local themelist = utils.get_themedata()

M.theme_to_html = function(name, cwd)
  local html_path = cwd .. "/src/lib/vihtml/" .. name .. ".svelte"
  local css_path = cwd .. "/src/lib/vihtml/" .. name .. ".css"
  local code = utils.win_to_html(name)

  utils.write_file(html_path, code.html)
  utils.write_file(css_path, code.css)
end

M.open_multi_langs = function(theme_name, cwd)
  local languages = vim.fn.readdir(cwd .. "/code_samples")

  for _, lang in ipairs(languages) do
    local dirpath = cwd .. "/code_samples/" .. lang .. "/"
    local code_file = vim.fn.readdir(dirpath)[1]
    local filepath = dirpath .. code_file
    vim.cmd("e " .. filepath)
    M.theme_to_html(theme_name .. "_" .. lang, cwd)
  end
end

M.base46_themes_html = function()
  local cwd = vim.uv.cwd()

  for _, v in ipairs(themelist) do
    for _, name in ipairs(v.variants) do
      vim.cmd("colorscheme " .. name)
      M.open_multi_langs(name, cwd)
    end
  end

  local themelist_json = vim.json.encode(themelist)
  utils.write_file(cwd .. "/src/data.json", themelist_json)
end

M.base46_themes_html()
