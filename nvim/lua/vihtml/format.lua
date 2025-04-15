local gen_css = function(theme)
  local colors = require("base46.themes." .. theme).base_16
  local bg = colors.base02
  local fg = colors.base0D
  local hoverfg = colors.base08

  local str = string.format(
    [[ 
      pre::-webkit-scrollbar-track{
       -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
        background-color: #%s;
        width:10px;
      }

      pre::-webkit-scrollbar{width:6px; height:6px; background-color: #%s }
      pre::-webkit-scrollbar-thumb{ background-color: %s; width:5px;  height:5px; }
      pre::-webkit-scrollbar-thumb:hover{ background-color: %s; cursor:pointer; }
    ]],
    bg,
    bg,
    fg,
    hoverfg
  )

  return str
end

return function(name, tb)
  local html_tb = {}
  local css_tb = {}
  local cur_scope
  local theme = name:gsub("_[^_]+$", "")

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
      table.insert(css_tb, "." .. theme .. v)
    elseif cur_scope == "body" then
      local block = string.gsub(v, 'class="', 'class="' .. theme .. " ")
      table.insert(html_tb, block)
    end
  end

  table.remove(css_tb, 1)
  table.remove(css_tb, 1)
  css_tb[1] = string.gsub(css_tb[1], "body", ".boxbg")

  table.remove(html_tb, 1)
  table.remove(html_tb, 1)
  table.insert(html_tb, 1, string.format('<section class="%s boxbg pt7 pb3 bordered rounded-2xl">', theme))
  table.insert(html_tb, "</section>")

  local html = table.concat(html_tb, "\n")
  html = html:gsub("{", "&#123;"):gsub("}", "&#125;")

  local script_tag = string.format('<script> import "$lib/vihtml/%s.css" </script>', theme)
  html = script_tag .. "\n\n" .. html

  local css = table.concat(css_tb, "\n")
  css = css:gsub("italic", "normal")
  css = gen_css(theme) .. css
  css = css:gsub("pre", "." .. theme .. " ")

  -- html_tb = vim.list_extend(css_tb, html_tb)
  return { html = html, css = css }
end
