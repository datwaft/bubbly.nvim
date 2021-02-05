-- ===========================
-- BUBBLY.NVIM PROGRESS BUBBLE
-- ===========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'
local settings = {
   color = vim.g.bubbly_colors.progress,
   inactive_color = vim.g.bubbly_inactive_color,
   style = vim.g.bubbly_styles.progress,
   inactive_style = vim.g.bubbly_inactive_style,
}

if not settings.color then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'progress', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'progress', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end

return function(inactive)
   return bubble_factory{
      {
         data = '%-8.(%l:%c%)',
         color = inactive and settings.inactive_color or settings.color.rowandcol,
         style = inactive and settings.inactive_style or settings.style.rowandcol,
      },
      {
         data = '%P',
         color = inactive and settings.inactive_color or settings.color.percentage,
         style = inactive and settings.inactive_style or settings.style.percentage,
      },
   }
end
