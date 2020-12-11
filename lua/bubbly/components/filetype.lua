-- ===========================
-- BUBBLY.NVIM FILETYPE BUBBLE
-- ===========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   if inactive then return '' end
   local filetype = vim.bo.filetype
   if filetype == '' then filetype = vim.g.bubbly_tags.filetype.noft
   else filetype = filetype:lower() end
   return bubble_factory{{
      data = filetype,
      color = vim.g.bubbly_colors.filetype,
      style = vim.g.bubbly_styles.filetype,
   }}
end
