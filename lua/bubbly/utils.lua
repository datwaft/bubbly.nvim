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
-- =========================
-- Generate highlight string
-- =========================
M.highlight = function(name, foreground, background, special)
   local command = 'highlight '
   command = command .. name .. ' '
   command = command .. 'guifg=' .. foreground .. ' '
   command = command .. 'guibg=' .. background .. ' '
   if special then
      command = command .. 'gui=' .. special .. ' '
   end
   return command
end
-- ============
-- Finalization
-- ============
   return M
