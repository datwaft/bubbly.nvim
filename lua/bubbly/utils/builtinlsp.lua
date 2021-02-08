-- =================
-- BUILTIN LSP UTILS
-- =================
-- Created by PatOConnor43 <github.com/PatOConnor43>

-- ========
-- Preamble
-- ========

   local M = require'bubbly.core.module'.new('utils.builtinlsp')

-- ========
-- In range
-- ========

   -- Takes a position from `vim.api.nvim_win_get_cursor` and a range and checks if the position is inside the range.
   M.in_range = function(pos, range)
      local line = pos[1]
      local char = pos[2]
      if line < range.start.line or line > range['end'].line then return false end
      if line == range.start.line and char < range.start.character or line == range['end'].line and char > range['end'].character then
          return false
      end
      return true
   end

-- ===================
-- Extract LSP symbols
-- ===================

   -- This returns a list of symbols from a 'textDocument/documentSymbol' request.
   M.extract_lsp_symbols = function(accumulated_symbols, items)
      for _, item in ipairs(items or {}) do
         local range = nil
         if item.location then -- Item is a SymbolInformation
            range = item.location.range
         elseif item.range then -- Item is a DocumentSymbol
            range = item.range
         end
         if range then
            range.start.line = range.start.line + 1
            range['end'].line = range['end'].line + 1
         end
         table.insert(accumulated_symbols, {range = range, kind = item.kind, name = item.name})
         if item.children ~= nil then
            accumulated_symbols = M.extract_lsp_symbols(accumulated_symbols, item.children)
         end
      end
      return accumulated_symbols
   end

-- ============
-- Finalization
-- ============

   return M
