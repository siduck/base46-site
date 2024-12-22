local win_separator_css = function()
  local fg = vim.api.nvim_get_hl(0, { name = "winseparator" }).fg
  local color = "#" .. ("%06x"):format(fg)
  return "border='0 r-1 solid " .. color .. "'"
end

return function(name, tb, w, h, normal_hl)
  local html_tb = {}
  local css_tb = {}
  local cur_scope

  for _, v in ipairs(tb) do
    if v == "<style>" then
      cur_scope = "css"
    elseif v == "</style>" then
      cur_scope = nil
    elseif v == "</head>" then
      cur_scope = "body"
    elseif v == "</body>" then
      cur_scope = nil
    end

    if cur_scope == "css" then
      table.insert(css_tb, "." .. name .. v)
    elseif cur_scope == "body" then
      local block = string.gsub(v, 'class="', 'class="' .. name .. " ")
      table.insert(html_tb, block)
    end
  end

  table.remove(css_tb, 1)
  table.remove(css_tb, 1)
  table.remove(css_tb, 1)

  local main_css = ""
  local body_css = string.format("bg-[%s] text-[%s] ", normal_hl.bg, normal_hl.fg)
  local w_css = "w-[" .. w .. "px]"
  main_css = main_css .. body_css .. w_css

  table.remove(html_tb, 1)
  table.remove(html_tb, 1)

  local border = win_separator_css()

  table.insert(html_tb, 1, string.format('<section class="%s boxbg p-1 flex %s"  %s>', name, main_css, border))

  table.insert(html_tb, "</section>")

  local html = table.concat(html_tb, "\n")
  html = html:gsub("{", "&#123;"):gsub("}", "&#125;")

  -- html_tb = vim.list_extend(css_tb, html_tb)
  return {
    html = html,
    css = table.concat(css_tb, "\n"),
  }
end
