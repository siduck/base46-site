local state = require "vihtml.state"

return function(line_type, name)
  local data = vim.api.nvim_eval_statusline(
    vim.o[line_type],
    { highlights = true, use_tabline = line_type ~= "stl", fillchar = "@" }
  )

  local html = "<div class='stl'><pre flex>"
  local css = ""
  local str = data.str

  local highlights = data.highlights

  for i, highlight in ipairs(highlights) do
    local content_end_i

    if i == #highlights then
      content_end_i = #str
    else
      content_end_i = highlights[i + 1].start
    end

    local content = str:sub(highlight.start + 1, content_end_i)
    local has_fillchars = string.find(content, "@")

    if has_fillchars then
      content = ' '
    end

    local grow = has_fillchars and "flex-grow" or ""

    local get_hl = vim.api.nvim_get_hl(0, { name = highlight.group })
    local bg = "#" .. ("%06x"):format(get_hl.bg or 0)

    local fg = "#" .. ("%06x"):format(get_hl.fg or 0)

    local class = "stl" .. i .. line_type:sub(1, 1) .. name .. " " .. grow

    css = css .. string.format(" .%s { background: %s ; color:%s } ", string.match(class, "%S+"), bg, fg)

    content = '<span class="' .. class .. '">' .. content .. "</span>"

    html = html .. content
  end

  html = html .. "</pre></div>"

  return { html = html, css = css }
end
