-- =================
-- INPUT/OUPUT UTILS
-- =================
-- Created by datwaft <github.com/datwaft>

-- ========
-- Preamble
-- ========

   local M = require'bubbly.core.module'.new('utils.io')

-- =======
-- Warning
-- =======

   -- Output a warning message
   M.warning = function(message)
      vim.cmd([[echohl WarningMsg]])
      vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
      vim.cmd([[echohl None]])
   end

-- =====
-- Error
-- =====

   -- Output an error message
   M.error = function(message)
      vim.cmd([[echohl ErrorMsg]])
      vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
      vim.cmd([[echohl None]])
   end

-- ============
-- Finalization
-- ============

   return M
