-- ======================
-- BUBBLY.NVIM HIGHTLIGHT
-- ======================
-- Created by: datwaft [github.com/datwaft]

--   The palette follows the form:
--   {
--        background = string
--        foreground = string
--        black = string
--        red = string
--        green = string
--        yellow = string
--        blue = string
--        purple = string
--        cyan = string
--        white = string
--        lightgrey = string
--        darkgrey = string
--    }

-- ========
-- Preamble
-- ========
   local highlight_factory = require'bubbly.factories.highlight'
-- ============
-- Finalization
-- ============
   return function()
      dump('BubblyPalette', vim.g.bubbly_palette)
      highlight_factory(vim.g.bubbly_palette)
   end
