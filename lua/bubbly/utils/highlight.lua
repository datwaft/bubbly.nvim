-- ===============
-- HIGHLIGHT UTILS
-- ===============
-- Created by datwaft <github.com/datwaft>

-- ========
-- Preamble
-- ========

   local M = require'core.module'.new('utils.highlight')

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
      return 'Bubbly'..M.titlecase(foreground)..M.titlecase(background)..M.titlecase(special)
   end

-- ============
-- Finalization
-- ============

   return M
