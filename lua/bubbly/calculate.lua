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
      local branch = vim.fn.systemlist('cd ' .. vim.fn.expand('%:p:h:S') .. ' && git status --porcelain -b 2>/dev/null')[1]
      branch = branch:gsub([[^## No commits yet on (%w+)$]], '%1')
      branch = branch:gsub([[^##%s+(%w+).*$]], '%1')
      return branch
   end
-- ============
-- Finalization
-- ============
   return M
