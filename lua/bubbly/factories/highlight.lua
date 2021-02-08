-- =================
-- HIGHLIGHT FACTORY
-- =================
-- Created by datwaft <github.com/datwaft>

-- ========
-- Preamble
-- ========
   -- Extraction from utils
   local titlecase = require'bubbly.utils.string'.titlecase
   local highlight = require'bubbly.utils.highlight'.highlight
   local hlparser = require'bubbly.utils.highlight'.hlparser
-- ====================
-- Auxiliars definition
-- ====================
   -- Define autocmd auxiliar function
   local function execute_command(name, foreground, background, style)
      vim.cmd(highlight(name, foreground, background, style))
   end
   -- Define bubble highlight
   local function define_bubble_highlight(name, foreground, background, default_background)
      execute_command(name, background, foreground)
      execute_command(name..'Bold', background, foreground, 'bold')
      execute_command(name..'Italic', background, foreground, 'italic')
      execute_command(name..'Delimiter', foreground, default_background)
   end
-- ==================
-- Factory definition
-- ==================
   return function(palette)
      local fg = hlparser(palette.foreground)
      local bg = hlparser(palette.background)
      for k1, v1 in pairs(palette) do
         v1 = hlparser(v1)
         for k2, v2 in pairs(palette) do
            if k1 ~= k2 then
               v2 = hlparser(v2)
               local name = 'Bubbly'..titlecase(k2)..titlecase(k1)
               define_bubble_highlight(name, v1, v2, bg)
            end
         end
         if k1 ~= 'background' then
            define_bubble_highlight('Bubbly'..titlecase(k1), v1, bg, bg)
         end
      end
      execute_command('BubblyStatusLine', fg, bg)
      execute_command('BubblyTabLine', fg, bg)
   end
