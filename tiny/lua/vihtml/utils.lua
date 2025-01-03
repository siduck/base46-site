local M = {}

local tohtml = require("tohtml").tohtml
local format_html = require "vihtml.format"

M.wininfo = function(id)
  return { id = id }
end

M.get_win_order = function(wins)
  local order = {}

  for _, v in ipairs(wins) do
    local winconf = vim.api.nvim_win_get_config(v)

    if winconf.relative == "" then
      local wincol = vim.api.nvim_win_get_position(v)[2]
      order[wincol] = order[wincol] or {}
      table.insert(order[wincol], v)
    end
  end

  local col_order = vim.tbl_keys(order)
  table.sort(col_order)

  local result = vim.tbl_map(function(x)
    local section = #order[x] == 1 and order[x][1] or order[x]

    if type(section) == "table" then
      return vim.tbl_map(M.wininfo, section)
    else
      return M.wininfo(section)
    end
  end, col_order)

  return result
end

M.win_to_html = function(name)
  local min = vim.fn.line("w0", 1000)
  local max = vim.fn.line("w$", 1000)

  local code = tohtml(0, { number_lines = true, range = { min, max } })
  return format_html(name, code)
end

M.write_file = function(path, str)
  local file = io.open(path, "wb")

  if file then
    file:write(str)
    file:close()
  end
end

M.get_themedata = function()
  local themelist = require("nvchad.utils").list_themes()

  return vim.tbl_map(function(x)
    return { name = x }
  end, themelist)
end

return M
