-- ===================================
-- BUILTIN-LSP CURRENT FUNCTION BUBBLE
-- ===================================
-- Created by PatOConnor43 <github.com/PatOConnor43>

local settings = {
  color = vim.g.bubbly_colors.builtinlsp.current_function,
  style = vim.g.bubbly_styles.builtinlsp.current_function,
}

if not settings.color then
  require'bubbly.utils.io'.warning[[Couldn't load color configuration for the component 'builtinlsp.current_function', the default color will be used.]]
  settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
  require'bubbly.utils.io'.warning[[Couldn't load style configuration for the component 'builtinlsp.current_function', the default style will be used.]]
  settings.style = vim.g.bubbly_styles.default
end

-- Returns bubble that shows built-in lsp current function
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then return nil end
  local data = vim.b.bubbly_builtinlsp_current_function
  return {{
    data = data,
    color = settings.color,
    style = settings.style,
  }}
end
