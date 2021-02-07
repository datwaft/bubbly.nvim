-- ====================
-- MODULE CHECKING UTIL
-- ====================
-- Created by datwaft <github.com/datwaft>

return function(name)
   local exceptions = {
      'trunc',
      'truncate',
      'divisor',
      'division',
   }
   if type(name) ~= 'string' then return true end
   for _,e in ipairs(exceptions) do
      if e:lower() == name:lower() then return true end
   end
   return not not M.prerequire('bubbly.components.'..name:lower())
end
