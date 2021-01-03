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
      close = 'x',
   }
-- =======
-- Symbols
-- =======
   M.symbols = {
      default = 'PANIC!',

      path = {
         readonly = 'RO',
         unmodifiable = '',
         modified = '+',
      },
      signify = {
         added = '+%s',
         modified = '~%s',
         removed = '-%s',
      },
      coc = {
         error = 'E%s',
         warning = 'W%s',
      },
      builtinlsp = {
         diagnostic_count = {
            error = 'E%s',
            warning = 'W%s',
         },
      },
      branch = ' %s',
   }
-- ====
-- Tags
-- ====
   M.tags = {
      default = 'HELP ME PLEASE!',

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
      default = 'red',

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
         readonly = { background = 'lightgrey', foreground = 'foreground' },
         unmodifiable = { background = 'darkgrey', foreground = 'foreground' },
         path = 'white',
         modified = { background = 'lightgrey', foreground = 'foreground' },
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
         status = { background = 'lightgrey', foreground = 'foreground' },
      },
      builtinlsp = {
         diagnostic_count = {
            error = 'red',
            warning = 'yellow'
         },
         current_function = 'purple'
      },
      filetype = 'blue',
      progress = {
         rowandcol = { background = 'lightgrey', foreground = 'foreground' },
         percentage = { background = 'darkgrey', foreground = 'foreground' },
      },
      tabline = {
         active = 'blue',
         inactive = 'white',
      },
   }
   M.inactive_color = { background = 'lightgrey', foreground = 'foreground' }
-- ======
-- Styles
-- ======
   M.styles = {
      default = 'bold',

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
      builtinlsp = {
         diagnostic_count = {
            error = '',
            warning = ''
         },
         current_function = ''
      },
      filetype = '',
      progress = {
         rowandol = '',
         percentage = '',
      },
      tabline = {
         active = 'bold',
         inactive = '',
      },
   }
   M.inactive_style = ''
-- ==========
-- Statusline
-- ==========
   M.statusline = {
      'mode',

      'truncate',

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
      -- Palette
      vim.g.bubbly_palette = require'bubbly.utils'.fusion(M.palette, vim.g.bubbly_palette)
      -- Characters
      vim.g.bubbly_characters = require'bubbly.utils'.fusion(M.characters, vim.g.bubbly_characters)
      -- Symbols
      vim.g.bubbly_symbols = require'bubbly.utils'.fusion(M.symbols, vim.g.bubbly_symbols)
      -- Tags
      vim.g.bubbly_tags = require'bubbly.utils'.fusion(M.tags, vim.g.bubbly_tags)
      -- Colors
      vim.g.bubbly_colors = require'bubbly.utils'.fusion(M.colors, vim.g.bubbly_colors)
      if not vim.g.bubbly_inactive_color then
         vim.g.bubbly_inactive_color = M.inactive_color
      end
      -- Styles
      vim.g.bubbly_styles = require'bubbly.utils'.fusion(M.styles, vim.g.bubbly_styles)
      if not vim.g.bubbly_inactive_style then
         vim.g.bubbly_inactive_style = M.inactive_style
      end
      -- Tabline
      vim.g.bubbly_tabline = vim.g.bubbly_tabline or 1
      -- Statusline
      if not vim.g.bubbly_statusline or type(vim.g.bubbly_statusline) ~= 'table' then
         vim.g.bubbly_statusline = M.statusline
      end
      for _,e in ipairs(vim.g.bubbly_statusline) do
         if not require'bubbly.utils'.checkmodule(e) then
            print([[[BUBBLY.NVIM] => [WARNING] Couldn't find the module named ']]..e:lower()..[[', it will be ignored.]])
         end
      end
   end
-- ============
-- Finalization
-- ============
   return M
