-- ==================
-- BUBBLY.NVIM PLUGIN
-- ==================
-- Created by: datwaft [github.com/datwaft]

-- ========
-- Preamble
-- ========
   -- Module namespace declaration
   local M = {}
   -- Character definition
   local left = vim.g.bubbly_left or ''
   local right = vim.g.bubbly_right or ''
   -- Extraction from utils
   local titlecase = require'bubbly.utils'.titlecase
-- ====================
-- Factories definition
-- ====================
   local function bubble_factory(list)
   -- Example of list element:
   -- { data: string, color: string, style: string-optional }
      -- Verification of list type
      if type(list) ~= 'table' then return '' end
      -- Render delimiter of the bubble
      local function render_delimiter(delimiter, color)
         return '%#Bubble' .. titlecase(color)  .. 'Delimiter#' .. delimiter
      end
      -- Auxiliar function to know if data is last in the list
      local function islast(current_index)
         for i = current_index + 1, #list do
            if list[i] and list[i].data and type(list[i].data) == 'string' and list[i].data ~= '' then
               return false
            end
         end
         return true
      end
      -- Beginning of function
      local isfirst = true
      local bubble = ''
      for i, e in ipairs(list) do
         dump('index: ' .. type(i), 'element: ' .. type(e) )
         if e and type(e) == 'table' and e.data and type(e.data) == 'string' and e.data ~= '' then
            -- check if element is the last one
            local islast = islast(i)
            -- normalize style
            if not e.style or type(e.style) ~= 'string' then e.style = '' end
            -- normalize color
            if not e.color or type(e.style) ~= 'string' then e.color = 'lightgrey' end
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
-- =====================
-- Components definition
-- =====================
   -- Mode bubble
   local function mode_bubble(inactive)
      local mode = vim.fn.mode()
      local data = vim.fn.mode(1):upper()
      local color
      local style = 'bold'
      if mode == 'n' then
         data = 'NORMAL'
         if not inactive then color = 'green' end
      elseif mode == 'i' then
         data = 'INSERT'
         if not inactive then color = 'blue' end
      elseif mode == 'v' or mode == 'V' or mode == '^V' then
         data = 'VISUAL'
         if not inactive then color = 'red' end
      elseif mode == 'c' then
         data = 'COMMAND'
         if not inactive then color = 'red' end
      elseif mode == 't' then
         data = 'TERMINAL'
         if not inactive then color = 'blue' end
      elseif mode == 'R' then
         data = 'REPLACE'
         if not inactive then color = 'yellow' end
      else
         if not inactive then color = 'white' end
      end
      return bubble_factory{{ data = data, color = color, style = style }}
   end
   -- Path bubble
   local function path_bubble(isinactive)
      return bubble_factory{
         isinactive or { data = vim.bo.ro and 'RO', color = 'lightgrey', style = 'bold' },
         isinactive or { data = vim.bo.ma or '', color = 'darkgrey' },
         { data = '%.30f', color = isinactive or 'white' },
         isinactive or { data = vim.bo.mod and '+', color = 'lightgrey' },
      }
   end
-- =====================
-- Statusline definition
-- =====================
   M.statusline = function(inactive)
      if inactive and type(inactive) ~= 'boolean' then inactive = true end
      local statusline = ''
      statusline = statusline .. mode_bubble(inactive) .. ' '
      statusline = statusline .. path_bubble(inactive) .. ' '
      return statusline
   end
-- ============
-- Finalization
-- ============
   return M
