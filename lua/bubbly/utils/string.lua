-- ============
-- STRING UTILS
-- ============
-- Created by datwaft <github.com/datwaft>

-- ========
-- Preamble
-- ========

   local M = require'bubbly.core.module'.new('utils.string')

-- =========
-- Titlecase
-- =========

   M.titlecase = function(str)
      if not str then return nil end
      if type(str) ~= 'string' then return nil end
      return str:sub(1,1):upper()..str:sub(2)
   end

-- ============
-- Finalization
-- ============

   return M
