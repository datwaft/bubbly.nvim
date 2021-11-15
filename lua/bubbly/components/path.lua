-- ===========
-- PATH BUBBLE
-- ===========
-- Created by datwaft <github.com/datwaft>

local settings = {
  symbol = vim.g.bubbly_symbols,
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require("bubbly.utils.module").process_settings

settings = process_settings(settings, "path")

settings.inactive_color = vim.g.bubbly_inactive_color
settings.inactive_style = vim.g.bubbly_inactive_style

---@type fun(filter: table): boolean
local process_filter = require("bubbly.utils.module").process_filter

-- Returns bubble that shows current file path
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if not process_filter(settings.filter) then
    return nil
  end
  return {
    inactive or {
      data = vim.bo.ro and settings.symbol.readonly,
      color = settings.color.readonly,
      style = settings.style.readonly,
    },
    inactive or {
      data = vim.bo.ma or settings.symbol.unmodifiable,
      color = settings.color.unmodifiable,
      style = settings.style.unmodifiable,
    },
    {
      data = "%.30f",
      color = inactive and settings.inactive_color or settings.color.path,
      style = inactive and settings.inactive_style or settings.style.path,
    },
    inactive or {
      data = vim.bo.mod and settings.symbol.modified,
      color = settings.color.modified,
      style = settings.style.modified,
    },
  }
end
