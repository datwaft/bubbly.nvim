-- ==================
-- BUBBLY.NVIM PLUGIN
-- ==================
-- Created by: datwaft [github.com/datwaft]

-- ========
-- Preamble
-- ========
   -- Character definition
   local left = vim.g.bubbly_characters.left
   local right = vim.g.bubbly_characters.right
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
      local data
      local color
      local style = vim.g.bubbly_styles.mode
      if mode == 'n' then
         data = vim.g.bubbly_tags.mode.normal
         if not inactive then color = vim.g.bubbly_colors.mode.normal end
      elseif mode == 'i' then
         data = vim.g.bubbly_tags.mode.insert
         if not inactive then color = vim.g.bubbly_colors.mode.insert end
      elseif mode == 'v' or mode == 'V' then
         data = vim.g.bubbly_tags.mode.visual
         if not inactive then color = vim.g.bubbly_colors.mode.visual end
      elseif mode == '^V' or mode == '' then
         data = vim.g.bubbly_tags.mode.visualblock
         if not inactive then color = vim.g.bubbly_colors.mode.visualblock end
      elseif mode == 'c' then
         data = vim.g.bubbly_tags.mode.command
         if not inactive then color = vim.g.bubbly_colors.mode.command end
      elseif mode == 't' then
         data = vim.g.bubbly_tags.mode.terminal
         if not inactive then color = vim.g.bubbly_colors.mode.terminal end
      elseif mode == 'R' then
         data = vim.g.bubbly_tags.mode.replace
         if not inactive then color = vim.g.bubbly_colors.mode.replace end
      else
         data = vim.g.bubbly_tags.mode.default
         if not inactive then color = vim.g.bubbly_colors.mode.default end
      end
      return bubble_factory{{ data = data, color = color, style = style }}
   end
   -- Path bubble
   local function path_bubble(inactive)
      return bubble_factory{
         inactive or {
            data = vim.bo.ro and vim.g.bubbly_symbols.path.readonly,
            color = vim.g.bubbly_colors.path.readonly,
            style = vim.g.bubbly_styles.path.readonly,
         },
         inactive or {
            data = vim.bo.ma or vim.g.bubbly_symbols.path.unmodifiable,
            color = vim.g.bubbly_colors.path.unmodifiable,
            style = vim.g.bubbly_styles.path.unmodifiable,
         },
         {
            data = '%.30f',
            color = inactive or 'white',
            style = vim.g.bubbly_styles.path.path,
         },
         inactive or {
            data = vim.bo.mod and vim.g.bubbly_symbols.path.modified,
            color = vim.g.bubbly_colors.path.modified,
            style = vim.g.bubbly_styles.path.modified,
         },
      }
   end
   -- Branch bubble
   local function branch_bubble(inactive)
      if inactive then return '' end
      return bubble_factory{{
         data = vim.b.git_branch,
         color = vim.g.bubbly_colors.branch,
         style = vim.g.bubbly_styles.branch,
      }}
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
         {
            data = added ~= 0 and vim.g.bubbly_symbols.signify.added .. added,
            color = vim.g.bubbly_colors.signify.added,
            style = vim.g.bubbly_styles.signify.added,
         },
         {
            data = modified ~= 0 and vim.g.bubbly_symbols.signify.modified .. modified,
            color = vim.g.bubbly_colors.signify.modified,
            style = vim.g.bubbly_styles.signify.modified,
         },
         {
            data = removed ~= 0 and vim.g.bubbly_symbols.signify.removed .. removed,
            color = vim.g.bubbly_colors.signify.removed,
            style = vim.g.bubbly_styles.signify.removed,
         },
      }
   end
   -- Paste bubble
   local function paste_bubble(inactive)
      if inactive then return '' end
      return bubble_factory{{
         data = vim.o.paste and vim.g.bubbly_tags.paste,
         color = vim.g.bubbly_colors.paste,
         style = vim.g.bubbly_styles.paste,
      }}
   end
   -- coc.nvim bubble
   local function coc_bubble(inactive)
      if inactive then return '' end
      local info = vim.b.coc_diagnostic_info
      if info == nil or next(info) == nil then return '' end
      return bubble_factory{
         {
            data = info.error ~= 0 and vim.g.bubbly_symbols.coc.error .. info.error,
            color = vim.g.bubbly_colors.coc.error,
            style = vim.g.bubbly_styles.coc.error,
         },
         {
            data = info.warning ~= 0 and vim.g.bubbly_symbols.coc.warning .. info.warning,
            color = vim.g.bubbly_colors.coc.warning,
            style = vim.g.bubbly_styles.coc.warning,
         },
         {
            data = vim.g.coc_status,
            color = vim.g.bubbly_colors.coc.status,
            style = vim.g.bubbly_styles.coc.status,
         },
      }
   end
   -- Filetype bubble
   local function filetype_bubble(inactive)
      if inactive then return '' end
      local filetype = vim.bo.filetype
      if filetype == '' then filetype = vim.g.bubbly_tags.filetype.noft
      else filetype = filetype:lower() end
      return bubble_factory{{
         data = filetype,
         color = vim.g.bubbly_colors.filetype,
         style = vim.g.bubbly_styles.filetype,
      }}
   end
   -- Progress bubble
   local function progress_bubble(inactive)
      return bubble_factory{
         {
            data = '%-8.(%l:%c%)',
            color = vim.g.bubbly_colors.progress.rowandcol,
            style = vim.g.bubbly_styles.progress.rowandcol,
         },
         {
            data = '%P',
            color = ( inactive or vim.g.bubbly_colors.progress.percentage ),
            style = vim.g.bubbly_styles.progress.percentage,
         },
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
