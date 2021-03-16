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

   -- Outputs a raw warning message
   M.raw_warning = function(message)
      vim.cmd([[echohl WarningMsg]])
      vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
      vim.cmd([[echohl None]])
   end

   -- Outputs a warning message
   -- Prepends "[BUBBLY.NVIM] => [WARNING] " to the warning message
   M.warning = function(message)
     vim.cmd([[echohl WarningMsg]])
     vim.cmd(string.format([[echomsg "[BUBBLY.NVIM] [WARNING] %s"]],
       vim.fn.escape(message, "\"\\")))
     vim.cmd([[echohl None]])
   end

-- =====
-- Error
-- =====

   -- Outputs a raw error message
   M.raw_error = function(message)
      vim.cmd([[echohl ErrorMsg]])
      vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
      vim.cmd([[echohl None]])
   end

   -- Outputs an error message
   -- Prepends "[BUBBLY.NVIM] => [ERROR] " to the error message
   M.error = function(message)
     vim.cmd([[echohl ErrorMsg]])
     vim.cmd(string.format([[echomsg "[BUBBLY.NVIM] [ERROR] %s"]],
       vim.fn.escape(message, "\"\\")))
     vim.cmd([[echohl None]])
   end

-- ============
-- Finalization
-- ============

   return M
