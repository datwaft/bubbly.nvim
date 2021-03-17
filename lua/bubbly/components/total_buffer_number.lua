-- ==========================
-- TOTAL BUFFER NUMBER BUBBLE
-- ==========================
-- Created by kuznetsss <github.com/kuznetsss>

local settings = {
  color = vim.g.bubbly_colors.total_buffer_number,
  style = vim.g.bubbly_styles.total_buffer_number,
  symbol = vim.g.bubbly_symbols.total_buffer_number
}

if not settings.color then
  require'bubbly.utils.io'.warning[[Couldn't load color configuration for the component 'total_buffer_number', the default color will be used.]]
  settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
  require'bubbly.utils.io'.warning[[Couldn't load style configuration for the component 'total_buffer_number', the default style will be used.]]
  settings.style = vim.g.bubbly_styles.default
end
if not settings.symbol then
  require'bubbly.utils.io'.warning[[Couldn't load symbol configuration for the component 'total_buffer_number', the default symbol will be used.]]
  settings.symbol = vim.g.bubbly_symbols.default
end

-- Returns bubble that shows the total number of buffers open
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then return nil end
  return {{
    data = settings.symbol:format(#vim.fn['getbufinfo']({buflisted = 1})),
    color = settings.color,
    style = settings.style,
  }}
end
