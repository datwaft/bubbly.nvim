-- ===========================
-- BUBBLY.NVIM COC.NVIM BUBBLE
-- ===========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   if inactive then return '' end
   local info = vim.b.coc_diagnostic_info
   if info == nil or next(info) == nil then return '' end
   return bubble_factory{
      {
         data = info.error ~= 0 and vim.g.bubbly_symbols.coc.error .. info.error,
         color = vim.g.bubbly_colors.coc.error,
         style = vim.g.bubbly_styles.coc.error,
      },
      {
         data = info.warning ~= 0 and vim.g.bubbly_symbols.coc.warning .. info.warning,
         color = vim.g.bubbly_colors.coc.warning,
         style = vim.g.bubbly_styles.coc.warning,
      },
      {
         data = vim.g.coc_status,
         color = vim.g.bubbly_colors.coc.status,
         style = vim.g.bubbly_styles.coc.status,
      },
   }
end
