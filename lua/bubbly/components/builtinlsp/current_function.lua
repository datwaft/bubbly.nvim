-- ==============================================
-- BUBBLY.NVIM BUILTINLSP CURRENT FUNCTION BUBBLE
-- ==============================================
-- Created by: PatOConnor43 [github.com/PatOConnor43]

local bubble_factory = require'bubbly.factories.bubble'
local settings = {
   color = vim.g.bubbly_colors.builtinlsp.current_function,
   style = vim.g.bubbly_styles.builtinlsp.current_function,
}

if not settings.color then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'builtinlsp.current_function', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'builtinlsp.current_function', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end

return function(inactive)
   if inactive then return '' end
   local data = vim.b.bubbly_current_function
   return bubble_factory{{
         data = data,
         color = settings.color,
         style = settings.style,
   }}
end
