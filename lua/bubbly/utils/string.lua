-- ============
-- STRING UTILS
-- ============
-- Created by datwaft <github.com/datwaft>

local M = require'bubbly.core.module'.new('utils.string')

-- Returns a titlecase version of the string
-- e.g. hello world -> Hello World
---@param str string
---@return string
function M.titlecase(str)
  if not str then return nil end
  if type(str) ~= 'string' then return nil end
  local result = string.gsub(str, "(%a)([%w_']*)", function(first, rest)
    return first:upper()..rest:lower()
  end)
  return result
end

-- Returns a list of strings as a result of splitting the original string by the delimiter
---@param str string
---@param delimiter string
---@return string[]
function M.split(str, delimiter)
  if delimiter == nil then
    delimiter = '%s'
  end
  local result = {}
  for value in string.gmatch(str, "([^"..delimiter.."]+)") do
    result[#result + 1] = value
  end
  return result
end

return M
