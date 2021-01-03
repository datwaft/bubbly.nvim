-- ==========================
-- BUBBLY.NVIM SIGNIFY BUBBLE
-- ==========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'
local settings = {
   color = vim.g.bubbly_colors.signify,
   style = vim.g.bubbly_styles.signify,
   symbol = vim.g.bubbly_symbols.signify,
}

return function(inactive)
   if inactive then return '' end
   if vim.fn.exists('*sy#repo#get_stats') == 0 then return '' end
   local added, modified, removed = unpack(vim.fn['sy#repo#get_stats']())
   if added == -1 then added = 0 end
   if modified == -1 then modified = 0 end
   if removed == -1 then removed = 0 end
   return bubble_factory{
      {
         data = added ~= 0 and settings.symbol.added:format(added),
         color = settings.color.added,
         style = settings.style.added,
      },
      {
         data = modified ~= 0 and settings.symbol.modified:format(modified),
         color = settings.color.modified,
         style = settings.style.modified,
      },
      {
         data = removed ~= 0 and settings.symbol.removed:format(removed),
         color = settings.color.removed,
         style = settings.style.removed,
      },
   }
end
