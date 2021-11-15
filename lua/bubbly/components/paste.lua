-- ============
-- PASTE BUBBLE
-- ============
-- Created by datwaft <github.com/datwaft>

local settings = {
  tag = vim.g.bubbly_tags,
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require("bubbly.utils.module").process_settings

settings = process_settings(settings, "paste")

---@type fun(filter: table): boolean
local process_filter = require("bubbly.utils.module").process_filter

-- Returns bubble that shows if paste mode is active
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then
    return nil
  end
  if not process_filter(settings.filter) then
    return nil
  end
  return { {
    data = vim.o.paste and settings.tag,
    color = settings.color,
    style = settings.style,
  } }
end
