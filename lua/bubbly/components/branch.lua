-- =========================
-- BUBBLY.NVIM BRANCH BUBBLE
-- =========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   if inactive then return '' end
   local data = vim.b.git_branch
   if data ~= '' then
      data = vim.g.bubbly_symbols.branch .. data
   end
   return bubble_factory{{
      data = data,
      color = vim.g.bubbly_colors.branch,
      style = vim.g.bubbly_styles.branch,
   }}
end
