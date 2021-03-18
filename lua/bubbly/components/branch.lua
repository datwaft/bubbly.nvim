-- =============
-- BRANCH BUBBLE
-- =============
-- Created by datwaft <github.com/datwaft>

local settings = {
  symbol = vim.g.bubbly_symbols,
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require'bubbly.utils.module'.process_settings

settings = process_settings(settings, 'branch')

---@type fun(filter: table): boolean
local process_filter = require'bubbly.utils.module'.process_filter

-- Returns bubble that shows current file branch
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then return nil end
  if not process_filter(settings.filter) then return nil end
  local data = vim.b.bubbly_branch
  if data ~= '' then
    data = settings.symbol:format(data)
  end
  return {{
    data = data,
    color = settings.color,
    style = settings.style,
  }}
end
