-- ==========================
-- BUBBLY.NVIM SIGNIFY BUBBLE
-- ==========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   if inactive then return '' end
   if vim.fn.exists('*sy#repo#get_stats') == 0 then return '' end
   local added, modified, removed = unpack(vim.fn['sy#repo#get_stats']())
   if added == -1 then added = 0 end
   if modified == -1 then modified = 0 end
   if removed == -1 then removed = 0 end
   return bubble_factory{
      {
         data = added ~= 0 and vim.g.bubbly_symbols.signify.added .. added,
         color = vim.g.bubbly_colors.signify.added,
         style = vim.g.bubbly_styles.signify.added,
      },
      {
         data = modified ~= 0 and vim.g.bubbly_symbols.signify.modified .. modified,
         color = vim.g.bubbly_colors.signify.modified,
         style = vim.g.bubbly_styles.signify.modified,
      },
      {
         data = removed ~= 0 and vim.g.bubbly_symbols.signify.removed .. removed,
         color = vim.g.bubbly_colors.signify.removed,
         style = vim.g.bubbly_styles.signify.removed,
      },
   }
end
