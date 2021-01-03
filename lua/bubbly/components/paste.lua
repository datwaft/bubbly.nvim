-- ========================
-- BUBBLY.NVIM PASTE BUBBLE
-- ========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'
local settings = {
   tag = vim.g.bubbly_tags.paste,
   color = vim.g.bubbly_colors.paste,
   style = vim.g.bubbly_styles.paste,
}

return function(inactive)
   if inactive then return '' end
   return bubble_factory{{
      data = vim.o.paste and settings.tag,
      color = settings.color,
      style = settings.style,
   }}
end
