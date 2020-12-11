-- =========================
-- BUBBLY.NVIM BRANCH BUBBLE
-- =========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   if inactive then return '' end
   return bubble_factory{{
      data = vim.g.bubbly_symbols.branch .. vim.b.git_branch,
      color = vim.g.bubbly_colors.branch,
      style = vim.g.bubbly_styles.branch,
   }}
end
