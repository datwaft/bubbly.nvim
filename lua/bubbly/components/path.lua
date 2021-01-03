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

if not settings.symbol then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load symbol configuration for the component 'path', the default symbol will be used.]]
   settings.symbol = vim.g.bubbly_symbols.default
end
if not settings.color then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'path', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'path', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end

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
