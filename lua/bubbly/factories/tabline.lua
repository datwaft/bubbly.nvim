-- ===========================
-- BUBBLY.NVIM TABLINE FACTORY
-- ===========================
-- Created by: datwaft [github.com/datwaft]

local bubble_factory = require'bubbly.factories.bubble'

return function()
   local this = vim.fn.tabpagenr()
   local tabline = {}
   for i = 1, vim.fn.tabpagenr('$') + 1 do
      local buflist = vim.fn.tabpagebuflist(i)
      local winnr = vim.fn.tabpagewinnr(i)
      local bufnr = buflist[winnr]
      local tabname = vim.fn.bufname(bufnr)
      local color = this == i and vim.g.bubbly_colors.tabline.active or vim.g.bubbly_colors.tabline.inactive
      local style = this == i and vim.g.bubbly_styles.tabline.active or vim.g.bubbly_styles.tabline.inactive
      tabline[#tabline] = {
         { pre = '%'..i..'T', data = tabname, post = '%T', color = color, style = style },
         { pre = '%'..i..'X', data = vim.g.bubbly_characters.close, post = '%X', color = 'darkgrey' },
      }
   end
   local result = ''
   for _, e in ipairs(tabline) do
      result = result .. bubble_factory(e) .. ' '
   end
end
