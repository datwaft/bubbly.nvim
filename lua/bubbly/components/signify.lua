-- ==============
-- SIGNIFY BUBBLE
-- ==============
-- Created by datwaft <github.com/datwaft>

local settings = {
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  symbol = vim.g.bubbly_symbols,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require("bubbly.utils.module").process_settings

settings = process_settings(settings, "signify")

---@type fun(filter: table): boolean
local process_filter = require("bubbly.utils.module").process_filter

-- Returns bubble that shows changes from signify
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then
    return nil
  end
  if not process_filter(settings.filter) then
    return nil
  end
  if vim.fn.exists("*sy#repo#get_stats") == 0 then
    return nil
  end
  local added, modified, removed = unpack(vim.fn["sy#repo#get_stats"]())
  if added == -1 then
    added = 0
  end
  if modified == -1 then
    modified = 0
  end
  if removed == -1 then
    removed = 0
  end
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
