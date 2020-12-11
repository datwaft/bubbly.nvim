-- ==========================
-- BUBBLY.NVIM BUBBLE FACTORY
-- ==========================
-- Created by: datwaft [github.com/datwaft]

local titlecase = require'bubbly.utils'.titlecase
local left = vim.g.bubbly_characters.left
local right = vim.g.bubbly_characters.right

return function(list)
-- Example of list element:
-- { data: string, color: string, style: string-optional }
   -- Render delimiter of the bubble
   local function render_delimiter(delimiter, color)
      return '%#Bubble' .. titlecase(color)  .. 'Delimiter#' .. delimiter
   end
   -- Auxiliar function to know if data is last in the list
   local function islast(current_index)
      for i = current_index + 1, #list do
         if list[i] and type(list[i]) == 'table' and list[i].data and type(list[i].data) == 'string' and list[i].data ~= '' then
            return false
         end
      end
      return true
   end
   -- Beginning of function
   local isfirst = true
   local bubble = ''
   for i, e in ipairs(list) do
      if e and type(e) == 'table' and e.data and type(e.data) == 'string' and e.data ~= '' then
         -- check if element is the last one
         local islast = islast(i)
         -- normalize style
         if not e.style or type(e.style) ~= 'string' then e.style = '' end
         -- normalize color
         if not e.color or type(e.color) ~= 'string' then e.color = 'lightgrey' end
         -- render left delimiter
         if isfirst then bubble = bubble .. render_delimiter(left, e.color) end
         -- render data style
         bubble = bubble .. '%#Bubble' .. titlecase(e.color) .. titlecase(e.style) .. '#'
         -- render data
         if not isfirst then bubble = bubble .. ' ' end
         bubble = bubble .. e.data:gsub('^%s*(.-)%s*$', '%1')
         if not islast then bubble = bubble .. ' ' end
         -- render right delimiter
         if islast then bubble = bubble .. render_delimiter(right, e.color) end
         -- disable isfirst
         isfirst = false
      end
   end
   return bubble
end
