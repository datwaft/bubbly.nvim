-- ===========
-- TABLE UTILS
-- ===========
-- Created by datwaft <github.com/datwaft>

local M = require("bubbly.core.module").new("utils.table")

-- Makes a deep copy of a table
---@param table table
---@return table
function M.deepcopy(table)
  local type = type(table)
  local copy
  if type == "table" then
    copy = {}
    for k, v in pairs(table) do
      copy[M.deepcopy(k)] = M.deepcopy(v)
    end
    setmetatable(copy, M.deepcopy(getmetatable(table)))
  else
    copy = table
  end
  return copy
end
-- Extracted from: http://lua-users.org/wiki/CopyTable

-- Returns the union of two tables with priority for the second one
---@param table1 table
---@param table2 table
---@return table
function M.fusion(table1, table2)
  if not table2 or type(table2) ~= "table" then
    return table1
  end
  if not table1 or type(table1) ~= "table" then
    return table2
  end
  local new = M.deepcopy(table1)
  for k2, v2 in pairs(table2) do
    if type(v2) == "table" then
      v2 = M.fusion(new[k2], v2)
    end
    new[k2] = v2
  end
  return new
end

-- Returns the list of the elements inside the list that pass the test
---@param list any[]
---@param test fun(index: any, value: any): boolean
function M.filter(list, test)
  local result = {}
  for i, v in ipairs(list) do
    if test(i, v) then
      table.insert(result, v)
    end
  end
  return result
end

return M
