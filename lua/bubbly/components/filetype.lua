-- ===========================
-- BUBBLY.NVIM FILETYPE BUBBLE
-- ===========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'
local settings = {
   tag = vim.g.bubbly_tags.filetype,
   color = vim.g.bubbly_colors.filetype,
   style = vim.g.bubbly_styles.filetype,
}

return function(inactive)
   if inactive then return '' end
   local filetype = vim.bo.filetype
   if filetype == '' then filetype = settings.tag.noft
   else filetype = filetype:lower() end
   return bubble_factory{{
      data = filetype,
      color = settings.color,
      style = settings.style,
   }}
end
