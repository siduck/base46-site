local function wininfo(id)
  return { id = id }
end

local M = {}

local tohtml = require("tohtml").tohtml
local format_html = require "vihtml.format"
local stl_to_html = require "vihtml.stl_html"

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
      return vim.tbl_map(wininfo, section)
    else
      return wininfo(section)
    end
  end, col_order)

  return result
end

M.win_to_html = function(id, name)
  local min = vim.fn.line("w0", id)
  local max = vim.fn.line("w$", id)

  local code = tohtml(id, { width = 400, number_lines = false, range = { min, max } })
  return format_html(name, code)
end

M.wins_to_html = function(name)
  local html = ""
  local css = ""

  local wins = vim.api.nvim_list_wins()
  local win_infos = M.get_win_order(wins)

  for _, v in ipairs(win_infos) do
    if v.id then
      local tmp = M.win_to_html(v.id, name)
      html = html .. tmp.html
      css = css .. tmp.css
    else
      -- flex row
      local col_div = '<div style="display: flex; flex-direction: column;">'

      for _, u in ipairs(v) do
        local tmp = M.win_to_html(u.id, name)
        col_div = col_div .. tmp.html
        css = css .. tmp.css
      end

      col_div = col_div .. "</div>"
      html = html .. col_div
    end
  end

  html = '<div style="display:flex;" class="nvimbufdiv">' .. html .. "</div>"

  local script_tag = string.format('<script> import "$lib/vicss/%s.css" </script>', name)

  local stl_code = stl_to_html("stl", name)
  local tbl_code = stl_to_html("tabline", name)

  html = tbl_code.html .. html .. stl_code.html
  css = tbl_code.css .. css .. stl_code.css

  html = "<div class='nvim_box'>" .. html .. "</div>"
  html = script_tag .. "\n\n" .. html

  return { html = html, css = css }
end

return M
