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
      vim.cmd('autocmd ColorScheme,VimEnter * ' .. highlight(name, foreground, background, style))
   end
   -- Define bubble highlight
   local function define_bubble_highlight(name, foreground, background, default_background)
      autocmd(name, background, foreground)
      autocmd(name .. 'Bold', background, foreground, 'bold')
      autocmd(name .. 'Italic', background, foreground, 'italic')
      autocmd(name .. 'Delimiter', foreground, default_background)
   end
-- ==================
-- Factory definition
-- ==================
   return function(palette)
      for k1, v1 in pairs(palette) do
         if k1 ~= 'background' and k1 ~= 'foreground' then
            for k2, v2 in pairs(palette) do
               if k2 ~= 'background' and k2 ~= 'foreground' and k1 ~= k2 then
                  local name = 'Bubbly' .. titlecase(k1) .. titlecase(k2)
                  define_bubble_highlight(name, v1, v2, palette.background)
               end
            end
         end
         define_bubble_highlight('Bubbly'..titlecase(k1), v1, palette.background, palette.background)
         define_bubble_highlight('Bubbly'..titlecase(k1)..'Dark', v1, palette.foreground, palette.background)
      end
      autocmd('StatusLine', palette.background, palette.foreground)
      autocmd('TabLine', palette.background, palette.foreground)
   end
