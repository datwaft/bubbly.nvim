-- ==================
-- BRANCH AUTOCOMMAND
-- ==================
-- Created by datwaft <github.com/datwaft>

return {{
   events = { 'BufEnter' },
   variable = {
      type = 'buffer',
      name = 'bubbly_branch',
   },
   command = function()
      local redirect = '2>/dev/null'
      if vim.fn.has('win64') ~= 0 or vim.fn.has('win32') ~= 0 or vim.fn.has('win16') ~= 0 then
         redirect = '2>$null'
      end
      local branch = vim.fn.systemlist('cd '..vim.fn.expand('%:p:h:S')..' '..redirect..' && git branch --show-current '..redirect)[1]
      if not branch or #branch == 0 then
         branch = vim.fn.systemlist('cd '..vim.fn.expand('%:p:h:S')..' '..redirect..' && git rev-parse --abbrev-ref HEAD '..redirect)[1]
      end
      if not branch or #branch == 0 then
         return ''
      end
      return branch
   end,
}}
