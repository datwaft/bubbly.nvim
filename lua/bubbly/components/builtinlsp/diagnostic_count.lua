-- ===================================
-- BUILTIN-LSP DIAGNOSTIC COUNT BUBBLE
-- ===================================
-- Created by PatOConnor43 <github.com/PatOConnor43>

local settings = {
  symbol = vim.g.bubbly_symbols.builtinlsp.diagnostic_count,
  color = vim.g.bubbly_colors.builtinlsp.diagnostic_count,
  style = vim.g.bubbly_styles.builtinlsp.diagnostic_count,
}

if not settings.symbol then
  require'bubbly.utils.io'.warning[[Couldn't load symbol configuration for the component 'builtinlsp.diagnostic_count', the default symbol will be used.]]
  settings.symbol = vim.g.bubbly_symbols.default
end
if not settings.color then
  require'bubbly.utils.io'.warning[[Couldn't load color configuration for the component 'builtinlsp.diagnostic_count', the default color will be used.]]
  settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
  require'bubbly.utils.io'.warning[[Couldn't load style configuration for the component 'builtinlsp.diagnostic_count', the default style will be used.]]
  settings.style = vim.g.bubbly_styles.default
end

-- Returns bubble that shows built-in lsp diagnostics
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then return nil end
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
