-- =============
-- BRANCH BUBBLE
-- =============
-- Created by datwaft <github.com/datwaft>

local settings = {
   symbol = vim.g.bubbly_symbols.branch,
   color = vim.g.bubbly_colors.branch,
   style = vim.g.bubbly_styles.branch,
}

if not settings.symbol then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load symbol configuration for the component 'branch', the default symbol will be used.]]
   settings.symbol = vim.g.bubbly_symbols.default
end
if not settings.color then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'branch', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'branch', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end

return function(inactive)
   if inactive then return nil end
   local data = vim.b.bubbly_branch
   if data ~= '' then
      data = settings.symbol:format(data)
   end
   return {{
      data = data,
      color = settings.color,
      style = settings.style,
   }}
end
