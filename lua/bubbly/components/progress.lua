-- ===============
-- PROGRESS BUBBLE
-- ===============
-- Created by datwaft <github.com/datwaft>

local settings = {
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  width = vim.g.bubbly_width,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require'bubbly.utils.module'.process_settings

settings = process_settings(settings, 'progress')

settings.inactive_color = vim.g.bubbly_inactive_color
settings.inactive_style = vim.g.bubbly_inactive_style

---@type fun(filter: table): boolean
local process_filter = require'bubbly.utils.module'.process_filter

-- Returns bubble that shows cursor position in file
---@param inactive boolean
---@return Segment[]
return function(inactive)
  dump(settings)
  if not process_filter(settings.filter) then return nil end
  return {
    {
      data = '%-'..settings.width.rowandcol..'.(%l:%c%)',
      color = inactive and settings.inactive_color or settings.color.rowandcol,
      style = inactive and settings.inactive_style or settings.style.rowandcol,
    },
    {
      data = '%P',
      color = inactive and settings.inactive_color or settings.color.percentage,
      style = inactive and settings.inactive_style or settings.style.percentage,
    },
  }
end
