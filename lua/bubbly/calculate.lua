local lsp_util = require('vim.lsp.util')
local lsp_proto = require('vim.lsp.protocol')
local utils = require('bubbly.utils')
-- =====================
-- BUBBLY.NVIM CALCULATE
-- =====================
-- Created by: datwaft [github.com/datwaft]


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

-- ==========
-- Builtin LSP Current Function
-- ==========
   M.current_function = function()
      if #vim.lsp.buf_get_clients(0) == 0 then
         return ''
      end
      local params = { textDocument = lsp_util.make_text_document_params() }
      local response, error = vim.lsp.buf_request_sync(0, 'textDocument/documentSymbol', params, 100)
      -- The expected response should not be empty and should contain a 'result'
      if response == nil or vim.tbl_isempty(response) or error ~= nil or response[1] == nil or response[1].result == nil then
         return ''
      end
      local symbols = utils.extract_lsp_symbols({}, response[1].result)
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
