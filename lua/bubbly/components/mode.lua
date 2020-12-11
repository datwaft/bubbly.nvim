-- =======================
-- BUBBLY.NVIM MODE BUBBLE
-- =======================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   local mode = vim.fn.mode()
   local data
   local color
   local style = vim.g.bubbly_styles.mode
   if mode == 'n' then
      data = vim.g.bubbly_tags.mode.normal
      if not inactive then color = vim.g.bubbly_colors.mode.normal end
   elseif mode == 'i' then
      data = vim.g.bubbly_tags.mode.insert
      if not inactive then color = vim.g.bubbly_colors.mode.insert end
   elseif mode == 'v' or mode == 'V' then
      data = vim.g.bubbly_tags.mode.visual
      if not inactive then color = vim.g.bubbly_colors.mode.visual end
   elseif mode == '^V' or mode == '' then
      data = vim.g.bubbly_tags.mode.visualblock
      if not inactive then color = vim.g.bubbly_colors.mode.visualblock end
   elseif mode == 'c' then
      data = vim.g.bubbly_tags.mode.command
      if not inactive then color = vim.g.bubbly_colors.mode.command end
   elseif mode == 't' then
      data = vim.g.bubbly_tags.mode.terminal
      if not inactive then color = vim.g.bubbly_colors.mode.terminal end
   elseif mode == 'R' then
      data = vim.g.bubbly_tags.mode.replace
      if not inactive then color = vim.g.bubbly_colors.mode.replace end
   else
      data = vim.g.bubbly_tags.mode.default
      if not inactive then color = vim.g.bubbly_colors.mode.default end
   end
   return bubble_factory{{ data = data, color = color, style = style }}
end
