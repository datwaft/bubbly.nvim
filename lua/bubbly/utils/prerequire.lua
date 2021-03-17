-- ================
-- PRE-REQUIRE UTIL
-- ================
-- Created by datwaft <github.com/datwaft>

-- Returns the result of requiring a module, if it fails it returns nil
---@return any
return function(...)
  local status, lib = pcall(require, ...)
  if status then return lib end
  return nil
end
