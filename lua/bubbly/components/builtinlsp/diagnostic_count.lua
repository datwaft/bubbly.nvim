local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   if inactive then return '' end
   local error_count = vim.lsp.diagnostic.get_count(0, 'Error')
   local warning_count = vim.lsp.diagnostic.get_count(0, 'Warning')
   return bubble_factory{
      {
            data = error_count ~= 0 and vim.g.bubbly_symbols.builtinlsp.diagnostic_count.error .. error_count,
            color = vim.g.bubbly_colors.builtinlsp.diagnostic_count.error,
            style = vim.g.bubbly_styles.builtinlsp.diagnostic_count.error


      },
      {
            data = warning_count ~= 0 and vim.g.bubbly_symbols.builtinlsp.diagnostic_count.warning .. warning_count,
            color = vim.g.bubbly_colors.builtinlsp.diagnostic_count.warning,
            style = vim.g.bubbly_styles.builtinlsp.diagnostic_count.warning


      },
   }
end
