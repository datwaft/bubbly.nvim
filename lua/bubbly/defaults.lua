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
         default = 'UNKOWN',
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
         path = 'white',
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
-- ======
-- Styles
-- ======
   M.styles = {
      mode = 'bold',
      path = {
         readonly = 'bold',
         unmodifiable = '',
         path = '',
         modified = '',
      },
      branch = 'bold',
      signify = {
         added = 'bold',
         modified = 'bold',
         removed = 'bold',
      },
      paste = 'bold',
      coc = {
         error = 'bold',
         warning = 'bold',
         status = ''
      },
      filetype = '',
      progress = {
         rowandol = '',
         percentage = '',
      },
   }
-- ==========
-- Statusline
-- ==========
   M.statusline = {
      'mode',
      'path',
      'branch',
      'signify',
      'coc',

      'divisor',

      'filetype',
      'progress',
   }
-- =============
-- Option fusion
-- =============
   M.fusion = function()
      vim.g.bubbly_palette = require'bubbly.utils'.fusion(M.palette, vim.g.bubbly_palette)
      vim.g.bubbly_characters = require'bubbly.utils'.fusion(M.characters, vim.g.bubbly_characters)
      vim.g.bubbly_symbols = require'bubbly.utils'.fusion(M.symbols, vim.g.bubbly_symbols)
      vim.g.bubbly_tags = require'bubbly.utils'.fusion(M.tags, vim.g.bubbly_tags)
      vim.g.bubbly_colors = require'bubbly.utils'.fusion(M.colors, vim.g.bubbly_colors)
      vim.g.bubbly_styles = require'bubbly.utils'.fusion(M.styles, vim.g.bubbly_styles)
      if not vim.g.bubbly_statusline then
         vim.g.bubbly_statusline = M.statusline
      end
   end
-- ============
-- Finalization
-- ============
   return M
