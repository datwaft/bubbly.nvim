-- ==========================
-- LSP-STATUS MESSAGES BUBBLE
-- ==========================
-- Created by kuznetsss <github.com/kuznetsss>

local settings = {
   color = vim.g.bubbly_colors.lsp_status.messages,
   style = vim.g.bubbly_styles.lsp_status.messages,
}

if not settings.color then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'lsp_status.messages', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'lsp_status.messages', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end

local get_messages = require'bubbly.utils.prerequire''lsp-status/messaging'
if not get_messages then
   require'bubbly.utils.io'.error[[[BUBBLY.NVIM] => [ERROR] Couldn't load 'lsp-status.messaging' for the component 'lsp_status.messages', the component will be disabled.]]
else
    get_messages = get_messages.messages
end

local spinner_frames = { '⣷', '⣯', '⣟', '⡿', '⢿', '⣻', '⣾', '⣽' }

return function()
   if get_messages == nil then return nil end

   local messages = get_messages()

   local contents = {}
   for _, msg in ipairs(messages) do
      local parsed_message = ''
      if msg.progress then
         parsed_message = parsed_message..msg.title
         if msg.message then
            parsed_message = parsed_message..' '..msg.message
         end

         if msg.percentage then
            parsed_message = parsed_message..' ('..math.floor(msg.percentage + 0.5)..'%%)'
         end

         if msg.spinner then
            parsed_message = spinner_frames[(msg.spinner % #spinner_frames) + 1]..' '..parsed_message
         end
      elseif msg.status then
         parsed_message = parsed_message..msg.content
      else
         parsed_message = parsed_message..msg.content
      end
      if contents[msg.name] == nil then
          contents[msg.name] = parsed_message
      else
        contents[msg.name] = contents[msg.name]..', '..parsed_message
      end
   end
   local result_str = ''
   for name,msg in pairs(contents) do
       result_str = result_str..name..': '..msg..' | '
   end
   result_str = result_str:sub(1,-4)

   return {{
      data = result_str,
      color = settings.color,
      style = settings.style,
   }}
end

