-- ==============
-- SIGNIFY BUBBLE
-- ==============
-- Created by datwaft <github.com/datwaft>

local settings = {
   color = vim.g.bubbly_colors.signify,
   style = vim.g.bubbly_styles.signify,
   symbol = vim.g.bubbly_symbols.signify,
}

if not settings.color then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'signify', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'signify', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end
if not settings.symbol then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load symbol configuration for the component 'signify', the default symbol will be used.]]
   settings.symbol = vim.g.bubbly_symbols.default
end

return function(inactive)
   if inactive then return nil end
   if vim.fn.exists('*sy#repo#get_stats') == 0 then return nil end
   local added, modified, removed = unpack(vim.fn['sy#repo#get_stats']())
   if added == -1 then added = 0 end
   if modified == -1 then modified = 0 end
   if removed == -1 then removed = 0 end
   return {
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
