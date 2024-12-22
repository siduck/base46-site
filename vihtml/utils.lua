local M = {}
local api = vim.api
local state = require "vihtml.state"

local tohtml = require("tohtml").tohtml
local format_html = require "vihtml.format"
local stl_to_html = require "vihtml.stl_html"
local get_hl = vim.api.nvim_get_hl

-- credits to image.nvim
M.save_term_w = function()
  local ffi = require "ffi"
  ffi.cdef [[
    typedef struct {
        unsigned short row;
      unsigned short col;
      unsigned short xpixel;
      unsigned short ypixel;
    } winsize;
    int ioctl(int, int, ...);
  ]]

  local TIOCGWINSZ = nil
  if vim.fn.has "linux" == 1 then
    TIOCGWINSZ = 0x5413
  elseif vim.fn.has "mac" == 1 then
    TIOCGWINSZ = 0x40087468
  elseif vim.fn.has "bsd" == 1 then
    TIOCGWINSZ = 0x40087468
  end

  ---@type { row: number, col: number, xpixel: number, ypixel: number }
  local sz = ffi.new "winsize"
  assert(ffi.C.ioctl(1, TIOCGWINSZ, sz) == 0, "Failed to get terminal size")

  local dimensions = {
    screen_x = sz.xpixel,
    screen_y = sz.ypixel,
    screen_cols = sz.col,
    screen_rows = sz.row,
    cell_width = sz.xpixel / sz.col,
    cell_height = sz.ypixel / sz.row,
  }

  state.term_dimensions = dimensions
  state.term_w = { w = dimensions.screen_y, h = dimensions.screen_y }
end

M.win_size_px = function(w, h)
  local terminal_window_w = state.term_w
  local cell_width = state.term_dimensions.cell_width

  local win_w = cell_width * w
  local win_h = cell_width * h

  return win_w, win_h
end

M.get_win_normal_hl = function(id)
  local winhl = vim.wo[id].winhl
  local win_normal = winhl:match "Normal:([^,]+)"

  local hl = get_hl(0, { name = "Normal" })
  local win_hl = get_hl(0, { name = win_normal })

  local bg = ("%06x"):format(win_hl.bg or hl.bg)
  local fg = ("%06x"):format(win_hl.fg or hl.fg)

  return { bg = "#" .. bg, fg = "#" .. fg }
end

M.wininfo = function(id)
  local w = api.nvim_win_get_width(id)
  local h = api.nvim_win_get_height(id)

  w, h = M.win_size_px(w, h)

  state.stl_w = w + state.stl_w

  local normal_hl = M.get_win_normal_hl(id)

  return { id = id, w = w, h = h, normal_hl = normal_hl }
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

M.win_to_html = function(id, name, w, h, normal_hl)
  local min = vim.fn.line("w0", id)
  local max = vim.fn.line("w$", id)
  local buf = vim.api.nvim_win_get_buf(id)
  local buflisted = vim.bo[buf].buflisted

  local code = tohtml(id, { number_lines = buflisted, range = { min, max } })
  return format_html(name, code, w, h, normal_hl)
end

M.wins_to_html = function(name)
  local html = ""
  local css = ""

  local wins = vim.api.nvim_list_wins()
  local win_infos = M.get_win_order(wins)

  for _, v in ipairs(win_infos) do
    if v.id then
      local tmp = M.win_to_html(v.id, name, v.w, v.h, v.normal_hl)
      html = html .. tmp.html
      css = css .. tmp.css
    else
      -- flex row
      local col_div = '<div style="display: flex; flex-direction: column;">'

      for _, u in ipairs(v) do
        local tmp = M.win_to_html(u.id, name, u.w, u.h, u.normal_hl)
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
