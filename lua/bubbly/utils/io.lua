-- =================
-- INPUT/OUPUT UTILS
-- =================
-- Created by datwaft <github.com/datwaft>

local M = require'bubbly.core.module'.new('utils.io')

-- Outputs a raw warning message
---@param message string
function M.raw_warning(message)
 vim.cmd([[echohl WarningMsg]])
 vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
 vim.cmd([[echohl None]])
end

-- Outputs a warning message
-- Prepends "[BUBBLY.NVIM] => [WARNING] " to the warning message
---@param message string
function M.warning(message)
 vim.cmd([[echohl WarningMsg]])
 vim.cmd(string.format([[echomsg "[BUBBLY.NVIM] [WARNING] %s"]],
  vim.fn.escape(message, "\"\\")))
 vim.cmd([[echohl None]])
end

-- Outputs a raw error message
---@param message string
function M.raw_error(message)
 vim.cmd([[echohl ErrorMsg]])
 vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
 vim.cmd([[echohl None]])
end

-- Outputs an error message
-- Prepends "[BUBBLY.NVIM] => [ERROR] " to the error message
---@param message string
function M.error(message)
 vim.cmd([[echohl ErrorMsg]])
 vim.cmd(string.format([[echomsg "[BUBBLY.NVIM] [ERROR] %s"]],
  vim.fn.escape(message, "\"\\")))
 vim.cmd([[echohl None]])
end

return M
