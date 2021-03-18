-- ===============
-- TABLINE FACTORY
-- ===============
-- Created by datwaft <github.com/datwaft>

local settings = {
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require'bubbly.utils.module'.process_settings
settings = process_settings(settings, 'tabline')

settings.character = vim.g.bubbly_characters.close

local bubble_factory = require'bubbly.factories.bubble'

-- Returns an tabline string following :help 'tabline'
---@return string
return function()
  local this = vim.fn.tabpagenr()
  local tabline = {}
  for i = 1, vim.fn.tabpagenr('$') do
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = buflist[winnr]
    local tabname = vim.fn.bufname(bufnr)
    if tabname == '' then tabname = '[No Name]' end
    local color = this == i and settings.color.active or settings.color.inactive
    local style = this == i and settings.style.active or settings.style.inactive
    tabline[#tabline + 1] = {
      { pre = '%'..i..'T', data = tabname, post = '%T', color = color, style = style },
      { pre = '%'..i..'X', data = settings.character, post = '%X', color = { background = 'darkgrey', foreground = 'foreground' } },
    }
  end
  local result = ''
  for _, e in ipairs(tabline) do
    result = result..bubble_factory(e)..' '
  end
  return result
end
