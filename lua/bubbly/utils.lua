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
-- ==============
-- Table deepcopy
-- ==============
   -- Extracted from: http://lua-users.org/wiki/CopyTable
   M.deepcopy = function(orig)
      local orig_type = type(orig)
      local copy
      if orig_type == 'table' then
         copy = {}
         for orig_key, orig_value in next, orig, nil do
            copy[M.deepcopy(orig_key)] = M.deepcopy(orig_value)
         end
         setmetatable(copy, M.deepcopy(getmetatable(orig)))
      else -- number, string, boolean, etc
         copy = orig
      end
      return copy
   end
-- ============
-- Table fusion
-- ============
   M.fusion = function(table1, table2)
      if not table2 or type(table2) ~= 'table' then return table1 end
      if not table1 or type(table1) ~= 'table' then return table2 end
      local new = M.deepcopy(table1)
      for k2, v2 in pairs(table2) do
         if type(v2) == 'table' then v2 = M.fusion(new[k2], v2) end
         new[k2] = v2
      end
      return table1
   end
-- ============
-- Finalization
-- ============
   return M
