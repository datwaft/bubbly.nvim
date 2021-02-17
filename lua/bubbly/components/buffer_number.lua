-- ====================
-- BUFFER NUMBER BUBBLE
-- ====================
-- Created by kuznetsss <github.com/kuznetsss>

local settings = {
   color = vim.g.bubbly_colors.buffer_number,
   style = vim.g.bubbly_styles.buffer_number,
   symbol = vim.g.bubbly_symbols.buffer_number
}

if not settings.color then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'buffer_number', the default color will be used.]]
   settings.color = 'orange' --vim.g.bubbly_colors.default
end
if not settings.style then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'buffer_number', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end
if not settings.symbol then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load symbol configuration for the component 'buffer_number', the default symbol will be used.]]
   settings.symbol = vim.g.bubbly_symbols.default
end

return function(inactive)
   if inactive then return nil end
   local buffers = vim.api.nvim_list_bufs()
   local buffer_number = 0
   for _, buf in pairs(buffers) do
       if vim.api.nvim_buf_is_loaded(buf) then
           buffer_number = buffer_number + 1
       end
   end
   return {
      {
         data = settings.symbol:format(buffer_number),
         color = settings.color,
         style = settings.style,
      }
  }
end
