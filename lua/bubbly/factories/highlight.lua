-- =============================
-- BUBBLY.NVIM HIGHLIGHT FACTORY
-- =============================
-- Created by: datwaft [github.com/datwaft]

-- ========
-- Preamble
-- ========
   -- Extraction from utils
   local titlecase = require'bubbly.utils'.titlecase
   local highlight = require'bubbly.utils'.highlight
-- ====================
-- Auxiliars definition
-- ====================
   -- Define autocmd auxiliar function
   local function autocmd(name, foreground, background, style)
      vim.cmd('autocmd ColorScheme,VimEnter * '..highlight(name, foreground, background, style))
   end
   -- Define bubble highlight
   local function define_bubble_highlight(name, foreground, background, default_background)
      autocmd(name, background, foreground)
      autocmd(name..'Bold', background, foreground, 'bold')
      autocmd(name..'Italic', background, foreground, 'italic')
      autocmd(name..'Delimiter', foreground, default_background)
   end
-- ==================
-- Factory definition
-- ==================
   return function(palette)
      for k1, v1 in pairs(palette) do
         for k2, v2 in pairs(palette) do
            if k1 ~= k2 then
               local name = 'Bubbly'..titlecase(k2)..titlecase(k1)
               define_bubble_highlight(name, v1, v2, palette.background)
            end
         end
         if k1 ~= 'background' then
            define_bubble_highlight('Bubbly'..titlecase(k1), v1, palette.background, palette.background)
         end
      end
      autocmd('BubblyStatusLine', palette.foreground, palette.background)
      autocmd('BubblyTabLine', palette.foreground, palette.background)
   end
