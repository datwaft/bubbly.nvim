-- ===================================
-- BUILTIN-LSP DIAGNOSTIC COUNT BUBBLE
-- ===================================
-- Created by PatOConnor43 <github.com/PatOConnor43>

local settings = {
  symbol = vim.g.bubbly_symbols,
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require'bubbly.utils.module'.process_settings

settings = process_settings(settings, 'builtinlsp.diagnostic_count')

---@type fun(filter: table): boolean
local process_filter = require'bubbly.utils.module'.process_filter

-- Returns bubble that shows built-in lsp diagnostics
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then return nil end
  if not process_filter(settings.filter) then return nil end
  local error_count = vim.lsp.diagnostic.get_count(0, 'Error')
  local warning_count = vim.lsp.diagnostic.get_count(0, 'Warning')
  return {
    {
      data = error_count ~= 0 and settings.symbol.error:format(error_count),
      color = settings.color.error,
      style = settings.style.error
    },
    {
      data = warning_count ~= 0 and settings.symbol.warning:format(warning_count),
      color = settings.color.warning,
      style = settings.style.warning
    },
  }
end
