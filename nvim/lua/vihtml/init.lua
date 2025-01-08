local utils = require "vihtml.utils"
local M = {}

local themelist = utils.get_themedata()

M.theme_to_html = function(name, cwd)
  local html_path = cwd .. "/src/lib/vihtml/" .. name .. ".svelte"
  local code = utils.win_to_html(name)
  utils.write_file(html_path, code.html)
  return code.css
end

M.open_multi_langs = function(theme_name, cwd)
  local languages = vim.fn.readdir(cwd .. "/code_samples")
  local css_str = ""

  for _, lang in ipairs(languages) do
    local dirpath = cwd .. "/code_samples/" .. lang .. "/"
    local code_file = vim.fn.readdir(dirpath)[1]
    local filepath = dirpath .. code_file
    vim.cmd("e " .. filepath)

    local x = M.theme_to_html(theme_name .. "_" .. lang, cwd)
    css_str = css_str .. x
  end

  utils.write_file(cwd .. "/src/lib/vihtml/" .. theme_name .. ".css", css_str)
end

M.base46_themes_html = function()
  local cwd = vim.uv.cwd()

  for _, v in ipairs(themelist) do
    vim.cmd.highlight "clear"
    require("nvconfig").base46.theme = v.name
    require("base46").load_all_highlights()
    M.open_multi_langs(v.name, cwd)
  end

  local themelist_json = vim.json.encode(themelist)
  utils.write_file(cwd .. "/src/data.json", themelist_json)
end

M.base46_themes_html()
