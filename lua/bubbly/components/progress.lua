-- ===========================
-- BUBBLY.NVIM PROGRESS BUBBLE
-- ===========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   return bubble_factory{
      {
         data = '%-8.(%l:%c%)',
         color = vim.g.bubbly_colors.progress.rowandcol,
         style = vim.g.bubbly_styles.progress.rowandcol,
      },
      {
         data = '%P',
         color = ( inactive or vim.g.bubbly_colors.progress.percentage ),
         style = vim.g.bubbly_styles.progress.percentage,
      },
   }
end
