-- ==============================================
-- BUBBLY.NVIM BUILTINLSP CURRENT FUNCTION BUBBLE
-- ==============================================
-- Created by: PatOConnor43 [github.com/PatOConnor43]

local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   if inactive then return '' end
   local data = vim.b.bubbly_current_function
   return bubble_factory{{
         data = data,
         color = vim.g.bubbly_colors.builtinlsp.current_function,
         style = vim.g.bubbly_styles.builtinlsp.current_function,
   }}
end
