-- ===============
-- COC.NVIM BUBBLE
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

settings = process_settings(settings, "coc")

---@type fun(filter: table): boolean
local process_filter = require("bubbly.utils.module").process_filter

-- Returns bubble that shows coc.nvim diagnostics
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then
    return nil
  end
  if not process_filter(settings.filter) then
    return nil
  end
  local info = vim.b.coc_diagnostic_info
  if info == nil or next(info) == nil then
    return nil
  end
  return {
    {
      data = info.error ~= 0 and settings.symbol.error:format(info.error),
      color = settings.color.error,
      style = settings.style.error,
    },
    {
      data = info.warning ~= 0 and settings.symbol.warning:format(info.warning),
      color = settings.color.warning,
      style = settings.style.warning,
    },
    {
      data = vim.g.coc_status,
      color = settings.color.status,
      style = settings.style.status,
    },
  }
end
