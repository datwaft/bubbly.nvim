-- =============================
-- LSP-STATUS DIAGNOSTICS BUBBLE
-- =============================
-- Created by kuznetsss <github.com/kuznetsss>

local settings = {
  symbol = vim.g.bubbly_symbols,
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require("bubbly.utils.module").process_settings

settings = process_settings(settings, "lsp_status.diagnostics")

local lsp_status = require("bubbly.utils.prerequire")("lsp-status")
if not lsp_status then
  require("bubbly.utils.io").error(
    [[Couldn't load 'lsp-status' for the component 'lsp_status.diagnostics', the component will be disabled.]]
  )
end

---@type fun(filter: table): boolean
local process_filter = require("bubbly.utils.module").process_filter

-- Returns bubble that shows lsp-status diagnostics
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if lsp_status == nil or inactive then
    return nil
  end
  if not process_filter(settings.filter) then
    return nil
  end
  local diagnostics = lsp_status.diagnostics(vim.api.nvim_get_current_buf())
  return {
    {
      data = diagnostics.errors ~= 0 and settings.symbol.error:format(diagnostics.errors),
      color = settings.color.error,
      style = settings.style.error,
    },
    {
      data = diagnostics.warnings ~= 0 and settings.symbol.warning:format(diagnostics.warnings),
      color = settings.color.warning,
      style = settings.style.warning,
    },
    {
      data = diagnostics.info ~= 0 and settings.symbol.info:format(diagnostics.info),
      color = settings.color.info,
      style = settings.style.info,
    },
    {
      data = diagnostics.hints ~= 0 and settings.symbol.hint:format(diagnostics.hints),
      color = settings.color.hint,
      style = settings.style.hint,
    },
  }
end
