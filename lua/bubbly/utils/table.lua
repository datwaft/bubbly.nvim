-- ===========
-- TABLE UTILS
-- ===========
-- Created by datwaft <github.com/datwaft>

-- ========
-- Preamble
-- ========

   local M = require'core.module'.new('utils.table')

-- ========
-- Deepcopy
-- ========

   -- Copies a table deeply
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
   -- Extracted from: http://lua-users.org/wiki/CopyTable

-- ======
-- Fusion
-- ======

   -- Fuses two tables recursively
   M.fusion = function(table1, table2)
      if not table2 or type(table2) ~= 'table' then return table1 end
      if not table1 or type(table1) ~= 'table' then return table2 end
      local new = M.deepcopy(table1)
      for k2, v2 in pairs(table2) do
         if type(v2) == 'table' then v2 = M.fusion(new[k2], v2) end
         new[k2] = v2
      end
      return new
   end

-- ======
-- Filter
-- ======

   -- Takes a list of elements and then calls the test function with each element.
   M.filter = function(list, test)
      local result = {}
      for i, v in ipairs(list) do
         if test(i, v) then
            table.insert(result, v)
         end
      end
      return result
   end

-- ============
-- Finalization
-- ============

   return M
