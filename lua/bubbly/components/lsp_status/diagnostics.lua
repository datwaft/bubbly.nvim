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
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load symbol configuration for the component 'lsp_status.diagnostics', the default symbol will be used.]]
   settings.symbol = vim.g.bubbly_symbols.default
end
if not settings.color then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'lsp_status.diagnostics', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'lsp_status.diagnostics', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end

local get_diagnostics = require'bubbly.utils.prerequire''lsp-status.diagnostics'
if not get_diagnostics then
   require'bubbly.utils.io'.error[[[BUBBLY.NVIM] => [ERROR] Couldn't load 'lsp-status.diagnostics' for the component 'lsp_status.diagnostics', the component will be disabled.]]
end

return function(inactive)
    if get_diagnostics == nil or inactive then return nil end
    local diagnostics = get_diagnostics(vim.api.nvim_get_current_buf())
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

