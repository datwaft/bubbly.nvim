-- =======================
-- BUBBLY.NVIM PATH BUBBLE
-- =======================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'
local settings = {
   symbol = vim.g.bubbly_symbols.path,
   color = vim.g.bubbly_colors.path,
   inactive_color = vim.g.bubbly_inactive_color,
   style = vim.g.bubbly_styles.path,
   inactive_style = vim.g.bubbly_inactive_style,
}

return function(inactive)
   return bubble_factory{
      inactive or {
         data = vim.bo.ro and settings.symbol.readonly,
         color = settings.color.readonly,
         style = settings.style.readonly,
      },
      inactive or {
         data = vim.bo.ma or settings.symbol.unmodifiable,
         color = settings.color.unmodifiable,
         style = settings.style.unmodifiable,
      },
      {
         data = '%.30f',
         color = inactive and settings.inactive_color or settings.color.path,
         style = inactive and settings.inactive_style or settings.style.path,
      },
      inactive or {
         data = vim.bo.mod and settings.symbol.modified,
         color = settings.color.modified,
         style = settings.style.modified,
      },
   }
end
