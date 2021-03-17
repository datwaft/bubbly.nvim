-- =============================
-- LSP-STATUS DIAGNOSTICS BUBBLE
-- =============================
-- Created by kuznetsss <github.com/kuznetsss>

local settings = {
  symbol = vim.g.bubbly_symbols.lsp_status.diagnostics,
  color = vim.g.bubbly_colors.lsp_status.diagnostics,
  style = vim.g.bubbly_styles.lsp_status.diagnostics,
}

if not settings.symbol then
  require'bubbly.utils.io'.warning[[Couldn't load symbol configuration for the component 'lsp_status.diagnostics', the default symbol will be used.]]
  settings.symbol = vim.g.bubbly_symbols.default
end
if not settings.color then
  require'bubbly.utils.io'.warning[[Couldn't load color configuration for the component 'lsp_status.diagnostics', the default color will be used.]]
  settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
  require'bubbly.utils.io'.warning[[Couldn't load style configuration for the component 'lsp_status.diagnostics', the default style will be used.]]
  settings.style = vim.g.bubbly_styles.default
end

local lsp_status = require'bubbly.utils.prerequire''lsp-status'
if not lsp_status then
  require'bubbly.utils.io'.error[[Couldn't load 'lsp-status' for the component 'lsp_status.diagnostics', the component will be disabled.]]
end

-- Returns bubble that shows lsp-status diagnostics
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if lsp_status == nil or inactive then return nil end
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
    }
  }
end
