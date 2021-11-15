-- ===============
-- GITSIGNS BUBBLE
-- ===============
-- Created by datwaft <github.com/datwaft>

local settings = {
  symbol = vim.g.bubbly_symbols,
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require("bubbly.utils.module").process_settings

settings = process_settings(settings, "gitsigns")

---@type fun(filter: table): boolean
local process_filter = require("bubbly.utils.module").process_filter

-- Returns bubble that shows current gitsigns status
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then
    return nil
  end
  if not process_filter(settings.filter) then
    return nil
  end
  if vim.b.gitsigns_status_dict == nil then
    return nil
  end
  local added = vim.b.gitsigns_status_dict.added
  local removed = vim.b.gitsigns_status_dict.removed
  local modified = vim.b.gitsigns_status_dict.changed
  return {
    {
      data = added ~= 0 and settings.symbol.added:format(added),
      color = settings.color.added,
      style = settings.style.added,
    },
    {
      data = modified ~= 0 and settings.symbol.modified:format(modified),
      color = settings.color.modified,
      style = settings.style.modified,
    },
    {
      data = removed ~= 0 and settings.symbol.removed:format(removed),
      color = settings.color.removed,
      style = settings.style.removed,
    },
  }
end
