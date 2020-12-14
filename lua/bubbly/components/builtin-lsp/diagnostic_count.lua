local bubble_factory = require'bubbly.factories.bubble'

return function(inactive)
   if inactive then return '' end
   local error_count = vim.lsp.diagnostic.get_count(0, 'Error')
   local warning_count = vim.lsp.diagnostic.get_count(0, 'Warning')
   local error_bubble = ''
   local warning_bubble = ''
   if error_count > 0 then
      error_bubble = {
            data = string.format('E:%d', error_count),
            color = 'red'
         }
   end
   if warning_count > 0 then
      warning_bubble = {
            data = string.format('W:%d', warning_count),
            color = 'yellow'
         }
   end
   return bubble_factory{
      error_bubble,
      warning_bubble
   }
end
