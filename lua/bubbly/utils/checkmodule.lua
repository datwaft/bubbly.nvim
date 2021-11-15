-- ====================
-- MODULE CHECKING UTIL
-- ====================
-- Created by datwaft <github.com/datwaft>

local prerequire = require("bubbly.utils.prerequire")

-- Checks if the module name exists inside 'bubbly.components'
---@param name string
---@return boolean
return function(name)
  local exceptions = {
    "trunc",
    "truncate",
    "divisor",
    "division",
  }
  if type(name) ~= "string" then
    return true
  end
  for _, e in ipairs(exceptions) do
    if e:lower() == name:lower() then
      return true
    end
  end
  return not not prerequire("bubbly.components." .. name:lower())
end
