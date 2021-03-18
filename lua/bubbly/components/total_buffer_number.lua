-- ==========================
-- TOTAL BUFFER NUMBER BUBBLE
-- ==========================
-- Created by kuznetsss <github.com/kuznetsss>

local settings = {
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  symbol = vim.g.bubbly_symbols,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require'bubbly.utils.module'.process_settings

settings = process_settings(settings, 'total_buffer_number')

---@type fun(filter: table): boolean
local process_filter = require'bubbly.utils.module'.process_filter

-- Returns bubble that shows the total number of buffers open
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then return nil end
  if not process_filter(settings.filter) then return nil end
  return {{
    data = settings.symbol:format(#vim.fn['getbufinfo']({buflisted = 1})),
    color = settings.color,
    style = settings.style,
  }}
end
