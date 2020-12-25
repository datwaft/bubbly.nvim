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
   local function autocmd(name, background, foreground, style)
      vim.cmd('autocmd ColorScheme,VimEnter * ' .. highlight(name, background, foreground, style))
   end
   -- Define bubble highlight
   local function define_bubble_highlight(name, background, foreground, default_background)
      autocmd(name, background, foreground)
      autocmd(name .. 'Bold', background, foreground)
      autocmd(name .. 'Italic', background, foreground)
      autocmd(name .. 'Delimiter', foreground, default_background)
   end
-- ==================
-- Factory definition
-- ==================
   return function(palette)
      for k1, v1 in ipairs(palette) do
         dump('k1', k1)
         if k1 ~= 'background' and k1 ~= 'foreground' then
            for k2, v2 in ipairs(palette) do
               dump('k2', k2)
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
