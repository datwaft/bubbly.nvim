-- ==========================
-- LSP-STATUS MESSAGES BUBBLE
-- ==========================
-- Created by kuznetsss <github.com/kuznetsss>

local settings = {
   color = vim.g.bubbly_colors.lsp_status.messages,
   style = vim.g.bubbly_styles.lsp_status.messages,
   timing = vim.g.bubbly_timing.lsp_status.messages,
}

if not settings.color then
   require'bubbly.utils.io'.warning[[Couldn't load color configuration for the component 'lsp_status.messages', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   require'bubbly.utils.io'.warning[[Couldn't load style configuration for the component 'lsp_status.messages', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end
if not settings.timing then
   require'bubbly.utils.io'.warning[[Couldn't load timing configuration for the component 'lsp_status.messages', the default timing will be used.]]
   settings.timing = vim.g.bubbly_timing.default
end

local lsp_status = require'bubbly.utils.prerequire''lsp-status'
if not lsp_status then
   require'bubbly.utils.io'.error[[Couldn't load 'lsp-status' for the component 'lsp_status.messages', the component will be disabled.]]
end

local spinner_frames = { '⣷', '⣯', '⣟', '⡿', '⢿', '⣻', '⣾', '⣽' }

local timer = vim.loop.new_timer()
local show_new_messages_allowed = true
local last_messages = nil

-- Enables updates of new messages
local function allow_update()
    show_new_messages_allowed = true
end

-- Returns bubble that shows lsp-status messages
---@param inactive boolean
---@return Segment[]
return function(inactive)
   if inactive then return nil end
   if lsp_status == nil then return nil end

   local messages = lsp_status.messages()
   if not show_new_messages_allowed then
      return last_messages
   end

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

   local result = {{
      data = result_str,
      color = settings.color,
      style = settings.style,
   }}
   show_new_messages_allowed = false
   last_messages = result
   timer:start(settings.timing.update_delay, 0, vim.schedule_wrap(allow_update))
   return result
end

