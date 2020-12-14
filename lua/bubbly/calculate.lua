local lsp_util = require('vim.lsp.util')
local lsp_proto = require('vim.lsp.protocol')
local utils = require('bubbly.utils')
-- =====================
-- BUBBLY.NVIM CALCULATE
-- =====================
-- Created by: datwaft [github.com/datwaft]


local extract_symbols = nil
extract_symbols = function(accumulated_symbols, items)
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
         accumulated_symbols = extract_symbols(accumulated_symbols, item.children)
      end
   end
   return accumulated_symbols
end
-- ========
-- Preamble
-- ========
   local M = {}
-- ==========
-- Git branch
-- ==========
   M.git_branch = function()
      local branch = vim.fn.systemlist('cd ' .. vim.fn.expand('%:p:h:S') .. ' && git status --porcelain -b 2>/dev/null')[1]
      if not branch or #branch == 0 then
         return ''
      end
      branch = branch:gsub([[^## No commits yet on (%w+)$]], '%1')
      branch = branch:gsub([[^##%s+(%w+).*$]], '%1')
      return branch
   end
   M.current_function = function()
      if #vim.lsp.buf_get_clients(0) == 0 then
         return ''
      end
      local params = { textDocument = lsp_util.make_text_document_params() }
      local result, error = vim.lsp.buf_request_sync(0, 'textDocument/documentSymbol', params, 1000)
      if result == nil or vim.tbl_isempty(result) or error ~= nil then
         return ''
      end
      local symbols = extract_symbols({}, result[1].result)
      symbols = utils.filter(symbols, function(_, v)
          return v.kind == lsp_proto.SymbolKind.Method or v.kind == lsp_proto.SymbolKind.Function or v.kind == lsp_proto.SymbolKind.Module
      end)
      local current_position = vim.api.nvim_win_get_cursor(0)
      local fn_name = ''
      for _, sym in ipairs(symbols) do
          if sym.range and utils.in_range(current_position, sym.range) then
             fn_name = lsp_proto.SymbolKind[sym.kind] .. ' ' .. sym.name
          end
      end

      return fn_name
   end
-- ============
-- Finalization
-- ============
   return M
