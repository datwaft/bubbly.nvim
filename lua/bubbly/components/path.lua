-- =======================
-- BUBBLY.NVIM PATH BUBBLE
-- =======================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   return bubble_factory{
      inactive or {
         data = vim.bo.ro and vim.g.bubbly_symbols.path.readonly,
         color = vim.g.bubbly_colors.path.readonly,
         style = vim.g.bubbly_styles.path.readonly,
      },
      inactive or {
         data = vim.bo.ma or vim.g.bubbly_symbols.path.unmodifiable,
         color = vim.g.bubbly_colors.path.unmodifiable,
         style = vim.g.bubbly_styles.path.unmodifiable,
      },
      {
         data = '%.30f',
         color = inactive or vim.g.bubbly_colors.path.path,
         style = vim.g.bubbly_styles.path.path,
      },
      inactive or {
         data = vim.bo.mod and vim.g.bubbly_symbols.path.modified,
         color = vim.g.bubbly_colors.path.modified,
         style = vim.g.bubbly_styles.path.modified,
      },
   }
end
