-- ======================
-- BUBBLY.NVIM HIGHTLIGHT
-- ======================
-- Created by: datwaft [github.com/datwaft]

--   The palette follows the form:
--   {
--        background = string,
--        foreground = string,
--        black = string,
--        red = string,
--        green = string,
--        yellow = string,
--        blue = string,
--        purple = string,
--        cyan = string,
--        white = string,
--        lightgrey = string,
--        darkgrey = string,
--    }

-- ========
-- Preamble
-- ========
   -- Extraction from utils
   local titlecase = require'bubbly.utils'.titlecase
   local highlight = require'bubbly.utils'.highlight
-- ==============================
-- Definition of bubble highlight
-- ==============================
   -- Define bubble highlight
   local function define_bubble_highlight(color, palette)
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color), palette.background, palette[color]))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Bold', palette.background, palette[color], 'bold'))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Italic', palette.background, palette[color], 'italic'))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Delimiter', palette[color], palette.background))
   end
   local function define_dark_bubble_highlight(color, palette)
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color), palette.foreground, palette[color]))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Bold', palette.foreground, palette[color], 'bold'))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Italic', palette.foreground, palette[color], 'italic'))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Delimiter', palette[color], palette.background))
   end
   -- define all status bar highlights
   local function define_highlights(palette)
      vim.cmd('autocmd VimEnter * ' .. highlight('StatusLine', palette.foreground, palette.background))
      define_bubble_highlight('black', palette)
      define_bubble_highlight('red', palette)
      define_bubble_highlight('green', palette)
      define_bubble_highlight('yellow', palette)
      define_bubble_highlight('blue', palette)
      define_bubble_highlight('purple', palette)
      define_bubble_highlight('cyan', palette)
      define_bubble_highlight('white', palette)
      define_dark_bubble_highlight('lightgrey', palette)
      define_dark_bubble_highlight('darkgrey', palette)
   end
-- ============
-- Finalization
-- ============
   return function()
      local palette = {
         background = "Black",
         foreground = "White",
         black = "Black",
         red = "Red",
         green = "Green",
         yellow = "Yellow",
         blue = "Blue",
         purple = "Magenta",
         cyan = "Cyan",
         white = "White",
         lightgrey = "LightGrey",
         darkgrey = "Grey",
      }
      if vim.g.bubbly_palette and type(vim.g.bubbly_palette) == 'table' then
         for k, v in pairs(vim.g.bubbly_palette) do palette[k] = v end
      end
      define_highlights(palette)
   end
