-- ==================
-- BUBBLY.NVIM PLUGIN
-- ==================
-- Created by: datwaft [github.com/datwaft]

-- ========
-- Preamble
-- ========
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
      elseif mode == 'v' or mode == 'V' or mode == '^V' or mode == '' then
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
   local function path_bubble(inactive)
      return bubble_factory{
         inactive or { data = vim.bo.ro and 'RO', color = 'lightgrey', style = 'bold' },
         inactive or { data = vim.bo.ma or '', color = 'darkgrey' },
         { data = '%.30f', color = inactive or 'white' },
         inactive or { data = vim.bo.mod and '+', color = 'lightgrey' },
      }
   end
   -- Branch bubble
   local function branch_bubble(inactive)
      if inactive then return '' end
      local color = 'purple'
      return bubble_factory{{ data = vim.b.git_branch, color = color, style = 'bold' }}
   end
   -- Signify bubble
   local function signify_bubble(inactive)
      if inactive then return '' end
      if vim.fn.exists('*sy#repo#get_stats') == 0 then return '' end
      local added, modified, removed = unpack(vim.fn['sy#repo#get_stats']())
      if added == -1 then added = 0 end
      if modified == -1 then modified = 0 end
      if removed == -1 then removed = 0 end
      return bubble_factory{
         { data = added ~= 0 and '+' .. added, color = 'green', style = 'bold' },
         { data = modified ~= 0 and '~' .. modified, color = 'blue', style = 'bold' },
         { data = removed ~= 0 and '-' .. removed, color = 'red', style = 'bold' },
      }
   end
   -- Paste bubble
   local function paste_bubble(inactive)
      if inactive then return '' end
      return bubble_factory{{ data = vim.o.paste and 'PASTE', color = 'red', style = 'bold' }}
   end
   -- coc.nvim bubble
   local function coc_bubble(inactive)
      if inactive then return '' end
      local info = vim.b.coc_diagnostic_info
      if info == nil or next(info) == nil then return '' end
      return bubble_factory{
         { data = info.error ~= 0 and 'E' .. info.error, color = 'red', style = 'bold' },
         { data = info.warning ~= 0 and 'W' .. info.warning, color = 'yellow', style = 'bold' },
         { data = vim.g.coc_status, color = 'lightgrey', style = bold },
      }
   end
   -- Filetype bubble
   local function filetype_bubble(inactive)
      if inactive then return '' end
      local filetype = vim.bo.filetype
      if filetype == '' then filetype = 'no ft'
      else filetype = filetype:lower() end
      return bubble_factory{{ data = filetype, color = 'blue' }}
   end
   -- Progress bubble
   local function progress_bubble(inactive)
      return bubble_factory{
         { data = '%-8.(%l:%c%)', color = 'lightgrey' },
         { data = '%P', color = ( inactive or 'darkgrey' ) },
      }
   end
-- ============
-- Finalization
-- ============
   return function(inactive)
      if inactive and type(inactive) ~= 'boolean' then inactive = true end
      local statusline = ''
      statusline = statusline .. mode_bubble(inactive) .. ' '
      statusline = statusline .. path_bubble(inactive) .. ' '
      do local instance = branch_bubble(inactive)
         if instance ~= '' then
            statusline = statusline .. instance .. ' '
         end
      end
      do local instance = signify_bubble(inactive)
         if instance ~= '' then
            statusline = statusline .. instance .. ' '
         end
      end
      do local instance = paste_bubble(inactive)
         if instance ~= '' then
            statusline = statusline .. instance .. ' '
         end
      end
      do local instance = coc_bubble(inactive)
         if instance ~= '' then
            statusline = statusline .. instance .. ' '
         end
      end

      statusline = statusline .. '%='

      do local instance = filetype_bubble(inactive)
         if instance ~= '' then
            statusline = statusline .. instance .. ' '
         end
      end
      statusline = statusline .. progress_bubble(inactive)

      return statusline
   end
