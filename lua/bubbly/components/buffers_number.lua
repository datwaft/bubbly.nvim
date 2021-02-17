
-- ===========
-- BUFFERS NUMBER BUBBLE
-- ===========
-- Created by kuznetsss <github.com/kuznetsss>

local settings = {
   color = vim.g.bubbly_colors.buffers_number,
   style = vim.g.bubbly_styles.buffers_number,
   symbol = vim.g.bubbly_symbols.buffers_number
}

if not settings.color then
   require'bubbly.utils.io'.warning[[[bubbly.nvim] => [warning] couldn't load color configuration for the component 'buffers_number', the default color will be used.]]
   settings.color = 'orange' --vim.g.bubbly_colors.default
end
if not settings.style then
   require'bubbly.utils.io'.warning[[[bubbly.nvim] => [warning] couldn't load style configuration for the component 'buffers_number', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end
if not settings.symbol then
   require'bubbly.utils.io'.warning[[[bubbly.nvim] => [warning] couldn't load symbol configuration for the component 'buffers_number', the default symbol will be used.]]
   settings.symbol = vim.g.bubbly_symbols.default
end

return function(inactive)
   if inactive then return nil end
   local buffers = vim.api.nvim_list_bufs()
   local buffers_number = 0
   for _, buf in pairs(buffers) do
       if vim.api.nvim_buf_is_loaded(buf) then
           buffers_number = buffers_number + 1
       end
   end
   return {
      {
         data = settings.symbol:format(buffers_number),
         color = settings.color,
         style = settings.style,
      }
  }
end
