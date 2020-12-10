-- ====================
-- BUBBLY.NVIM DEFAULTS
-- ====================
-- Created by: datwaft [github.com/datwaft]

-- ========
-- Preamble
-- ========
   local M = {}
-- =======
-- Palette
-- =======
   M.palette = {
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
-- ==========
-- Characters
-- ==========
   M.characters = {
      left = '',
      right = '',
   }
-- =======
-- Symbols
-- =======
   M.symbols = {
      path = {
         readonly = 'RO',
         unmodifiable = '',
         modified = '+',
      },
      signify = {
         added = '+',
         modified = '~',
         removed = '-',
      },
      coc = {
         error = 'E',
         warning = 'W',
      },
   }
-- ====
-- Tags
-- ====
   M.tags = {
      mode = {
         normal = 'NORMAL',
         insert = 'INSERT',
         visual = 'VISUAL',
         visualblock = 'VISUAL-B',
         command = 'COMMAND',
         terminal = 'TERMINAL',
         replace = 'REPLACE',
         default = nil,
      },
      paste = 'PASTE',
      filetype = {
         noft = 'no ft',
      },
   }
-- ======
-- Colors
-- ======
   M.colors = {
      mode = {
         normal = 'green',
         insert = 'blue',
         visual = 'red',
         visualblock = 'red',
         command = 'red',
         terminal = 'blue',
         replace = 'yellow',
         default = 'white'
      },
      path = {
         readonly = 'lightgrey',
         unmodifiable = 'darkgrey',
         modified = 'lightgrey',
      },
      branch = 'purple',
      signify = {
         added = 'green',
         modified = 'blue',
         removed = 'red',
      },
      paste = 'red',
      coc = {
         error = 'red',
         warning = 'yellow',
         status = 'lightgrey',
      },
      filetype = 'blue',
      progress = {
         rowandcol = 'lightgrey',
         percentage = 'darkgrey',
      },
   }
-- =============
-- Option fusion
-- =============
   M.fusion = function()
   end
-- ============
-- Finalization
-- ============
   return M
