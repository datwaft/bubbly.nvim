-- =================
-- BUBBLY.NVIM UTILS
-- =================
-- Created by: datwaft [github.com/datwaft]

-- ========
-- Preamble
-- ========
   -- Module namespace declaration
   local M = {}
-- =========================
-- Generate titlecase string
-- =========================
M.titlecase = function(str)
   return str:sub(1,1):upper() .. str:sub(2)
end
-- ============
-- Finalization
-- ============
   return M
