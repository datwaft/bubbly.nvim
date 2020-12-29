-- =====================
-- BUBBLY.NVIM CALCULATE
-- =====================
-- Created by: datwaft [github.com/datwaft]


-- ========
-- Preamble
-- ========
   local M = {}
-- ==========
-- Git branch
-- ==========
   M.git_branch = function()
      local branch = vim.fn.systemlist('cd '..vim.fn.expand('%:p:h:S')..' 2>/dev/null && git branch --show-current 2>/dev/null')[1]
      if not branch or #branch == 0 then
         branch = vim.fn.systemlist('cd '..vim.fn.expand('%:p:h:S')..' 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null')[1]
      end
      if not branch or #branch == 0 then
         return ''
      end
      return branch
   end
-- ============
-- Finalization
-- ============
   return M
