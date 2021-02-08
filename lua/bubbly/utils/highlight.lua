-- ===============
-- HIGHLIGHT UTILS
-- ===============
-- Created by datwaft <github.com/datwaft>

-- ========
-- Preamble
-- ========

   local M = require'bubbly.core.module'.new('utils.highlight')
   local titlecase = require'bubbly.utils.string'.titlecase

-- =========================
-- Generate highlight string
-- =========================

   -- Returns highlight string generated from parameters
   M.highlight = function(name, foreground, background, special)
      local command = 'highlight '
      command = command..name..' '
      command = command..'guifg='..foreground..' '
      command = command..'guibg='..background..' '
      if special then
         command = command..'gui='..special..' '
      end
      return command
   end

-- ==================
-- Get highlight name
-- ==================

   -- Returns highlight name for parameters
   M.gethighlight = function(foreground, background, special)
      if not foreground then foreground = '' end
      if not special then special = '' end
      return 'Bubbly'..titlecase(foreground)..titlecase(background)..titlecase(special)
   end

-- ==================================
-- Extract color from highlight group
-- ==================================

   -- Returns highlight name for parameters
   M.hlparser = function(usercolor)
      if string.sub(usercolor, 1, 1) == '#' then
         -- return the string as is if it represents a HEX
         return usercolor
      end

      -- Extract Group and foreground/background
      local hlGroup = string.match(usercolor, "(%w+)%s")

      if hlGroup == nil then
         -- This is the 256 naming colorscheme
         return usercolor
      end

      local key = string.match(usercolor, "%s(%w+)")

      -- Get colors from vim
      hlGroup = vim.api.nvim_get_hl_by_name(hlGroup, true)
      if hlGroup[key] then
         -- The color exists, return its HEX form
         return  string.format("#%x", hlGroup[key])
      end

      -- The color is absent, use a transparent color.
      return "None"
   end

-- ============
-- Finalization
-- ============

   return M
