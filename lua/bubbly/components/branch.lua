-- =========================
-- BUBBLY.NVIM BRANCH BUBBLE
-- =========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'
local settings = {
   symbol = vim.g.bubbly_symbols.branch,
   color = vim.g.bubbly_colors.branch,
   style = vim.g.bubbly_styles.branch,
}

return function(inactive)
   if inactive then return '' end
   local data = vim.b.git_branch
   if data ~= '' then
      data = settings.symbol:format(data)
   end
   return bubble_factory{{
      data = data,
      color = settings.color,
      style = settings.style,
   }}
end
