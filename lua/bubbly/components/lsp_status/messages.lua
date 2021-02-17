-- ===============
-- LSP-STATUS MESSAGES BUBBLE
-- ===============
-- Created by kuznetsss <github.com/kuznetsss>

local settings = {
   color = vim.g.bubbly_colors.lsp_status_messages,
   style = vim.g.bubbly_styles.lsp_status_messages,
}

if not settings.color then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'lsp_status_messages', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'lsp_status_messages', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end

local status, get_messages = pcall(require, 'lsp-status/messaging')
if not status then
   require'bubbly.utils.io'.error[[[BUBBLY.NVIM] => [ERROR] Couldn't load 'lsp-status/diagnostics' for the component 'lsp_status_diagnostics'.]]
   get_messages = nil
else
    get_messages = get_messages.messages
end
local spinner_frames = { '⣷', '⣯', '⣟', '⡿', '⢿', '⣻', '⣾', '⣽' }

return function()
    if get_messages == nil then return nil end

    local messages = get_messages()

    local result_str = ''
    for _, msg in ipairs(messages) do
        local contents = msg.name .. ': '
        if msg.progress then
          contents = contents .. msg.title
          if msg.message then
            contents = contents .. ' ' .. msg.message
          end

          if msg.percentage then
            contents = contents .. ' (' .. math.floor(msg.percentage + 0.5) .. '%)'
          end

          if msg.spinner then
            contents = spinner_frames[(msg.spinner % #spinner_frames) + 1] .. ' ' .. contents
          end
        elseif msg.status then
          contents = contents .. msg.content
        else
          contents = contents .. msg.content
        end
        result_str = result_str .. ' ' .. contents
    end

    return {
        {
             data = result_str,
             color = settings.color,
             style = settings.style,
        }
    }
end

