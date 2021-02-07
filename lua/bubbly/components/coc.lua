-- ===============
-- COC.NVIM BUBBLE
-- ===============
-- Created by datwaft <github.com/datwaft>

local bubble_factory = require'bubbly.factories.bubble'
local settings = {
   symbol = vim.g.bubbly_symbols.coc,
   color = vim.g.bubbly_colors.coc,
   style = vim.g.bubbly_styles.coc,
}

if not settings.symbol then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load symbol configuration for the component 'coc', the default symbol will be used.]]
   settings.symbol = vim.g.bubbly_symbols.default
end
if not settings.color then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'coc', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   print[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'coc', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end

return function(inactive)
   if inactive then return '' end
   local info = vim.b.coc_diagnostic_info
   if info == nil or next(info) == nil then return '' end
   return bubble_factory{
      {
         data = info.error ~= 0 and settings.symbol.error:format(info.error),
         color = settings.color.error,
         style = settings.style.error,
      },
      {
         data = info.warning ~= 0 and settings.symbol.warning:format(info.warning),
         color = settings.color.warning,
         style = settings.style.warning,
      },
      {
         data = vim.g.coc_status,
         color = settings.color.status,
         style = settings.style.status,
      },
   }
end
