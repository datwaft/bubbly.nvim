-- ==================
-- STATUSLINE FACTORY
-- ==================
-- Created by datwaft <github.com/datwaft>

local bubble_factory = require'bubbly.factories.bubble'

return function(list, inactive)
   local statusline = ''
   local left = true
   for _, e in ipairs(list) do
      local type = type(e)
      if type == 'table' then
         if not left then statusline = statusline..' ' end
         statusline = statusline..bubble_factory(e)
         if left then statusline = statusline..' ' end
      elseif type == 'function' then
         if not left then statusline = statusline..' ' end
         statusline = statusline..bubble_factory(e(inactive))
         if left then statusline = statusline..' ' end
      elseif type == 'string' then
         if left and e:lower() == 'divisor' or e:lower() == 'division' then
            statusline = statusline..'%='
            left = false
         elseif e:lower() == 'truc' or e:lower() == 'truncate' then
            statusline = statusline..'%<'
         else
            local component = require'bubbly.utils.prerequire'('bubbly.components.'..e:lower())
            if component then
               if not left then statusline = statusline..' ' end
               statusline = statusline..bubble_factory(component(inactive))
               if left then statusline = statusline..' ' end
            end
         end
      end
   end
   dump(statusline)
   return statusline
end
