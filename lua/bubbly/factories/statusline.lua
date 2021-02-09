-- ==================
-- STATUSLINE FACTORY
-- ==================
-- Created by datwaft <github.com/datwaft>

local bubble_factory = require'bubbly.factories.bubble'
local filter = require'bubbly.utils.table'.filter

local construct_statusline = function(list)
   local statusline = ''
   local alignment = 'left'
   for i, bubble in ipairs(list) do
      if bubble == '%=' then
         alignment = 'right'
      elseif bubble == '%<' then
         statusline = statusline..bubble
      elseif alignment == 'left' then
         if i ~= 1 then
            statusline = statusline..' '
         end
         statusline = statusline..bubble
      else
         statusline = statusline..bubble
         if i ~= #list then
            statusline = statusline..' '
         end
      end
   end
   return statusline
end

return function(list, inactive)
   local statusline = {}
   for _, e in ipairs(list) do
      local type = type(e)
      if type == 'table' then
         statusline[#statusline + 1] = bubble_factory(e)
      elseif type == 'function' then
         statusline[#statusline + 1] = bubble_factory(e(inactive))
      elseif type == 'string' then
         if e:lower() == 'divisor' or e:lower() == 'division' then
            statusline[#statusline + 1] = '%='
         elseif e:lower() == 'truc' or e:lower() == 'truncate' then
            statusline[#statusline + 1] = '%<'
         else
            local component = require'bubbly.utils.prerequire'('bubbly.components.'..e:lower())
            if component then
               statusline[#statusline + 1] = bubble_factory(component(inactive))
            end
         end
      end
   end
   dump(statusline)
   statusline = filter(statusline, function(_, e) return type(e) ~= 'string' or e == '' end)
   dump(statusline)
   dump(construct_statusline(statusline))
   return construct_statusline(statusline)
end
