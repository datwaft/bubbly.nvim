-- ================
-- PRE-REQUIRE UTIL
-- ================
-- Created by datwaft <github.com/datwaft>

return function(...)
   local status, lib = pcall(require, ...)
   if status then return lib end
   return nil
end

