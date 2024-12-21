return function(line_type, name)
  local data = vim.api.nvim_eval_statusline(vim.o[line_type], { highlights = true, use_tabline = line_type ~= "stl" })

  local html = "<div class='nvimbufdiv'><pre>"
  local css = ""
  local str = data.str
  local highlights = data.highlights

  for i, highlight in ipairs(highlights) do
    local content_end_i

    if i == #highlights then
      content_end_i = vim.api.nvim_strwidth(str)
    else
      content_end_i = highlights[i + 1].start
    end

    local content = str:sub(highlight.start + 1, content_end_i)

    local get_hl = vim.api.nvim_get_hl(0, { name = highlight.group })
    local bg = "#" .. ("%06x"):format(get_hl.bg or 0)
    local fg = "#" .. ("%06x"):format(get_hl.fg or 0)

    local class = "stl" .. i .. line_type:sub(1, 1) .. name

    css = css .. string.format(" .%s { background: %s ; color:%s } ", class, bg, fg)

    content = string.format('<span class="%s">' .. content .. "</span>", class)

    html = html .. content
  end

  html = html .. "</pre></div>"

  return { html = html, css = css }
end
