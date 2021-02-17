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
local spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' }
local previous_update_time = os.time()
local previous_result = nil
local update_time = 1 -- second

return function()
    if get_messages == nil then return nil end

    local current_time = os.time()
    if (current_time - previous_update_time) <= update_time then
        previous_update_time = current_time
        return previous_result
    end
    previous_update_time = current_time

    local messages = get_messages()

    local result = {}
    for _, msg in ipairs(messages) do
        local contents = msg.name .. ': '
        if msg.progress then
          contents = contents .. msg.title
          if msg.message then
            contents = contents .. ' ' .. msg.message
          end

          if msg.percentage then
            contents = contents .. ' (' .. msg.percentage .. ')'
          end

          if msg.spinner then
            contents = spinner_frames[(msg.spinner % #spinner_frames) + 1] .. ' ' .. contents
          end
        elseif msg.status then
          contents = contents .. msg.content
          --[[if msg.uri then
            local filename = vim.uri_to_fname(msg.uri)
            filename = vim.fn.fnamemodify(filename, ':~:.')
            local space = math.min(60, math.floor(0.6 * vim.fn.winwidth(0)))
            if #filename > space then
              filename = vim.fn.pathshorten(filename)
            end

            contents = '(' .. filename .. ') ' .. contents
          end]]--
        else
          contents = contents .. msg.content
        end
        table.insert(result,
          {
             data = contents,
             color = settings.color,
             style = settings.style,
          }
        )
    end

    previous_result = result
    return result
end

