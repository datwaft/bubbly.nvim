-- ===========
-- MODE BUBBLE
-- ===========
-- Created by datwaft <github.com/datwaft>

local settings = {
  tag = vim.g.bubbly_tags,
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require("bubbly.utils.module").process_settings

settings = process_settings(settings, "mode")

settings.inactive_color = vim.g.bubbly_inactive_color
settings.inactive_style = vim.g.bubbly_inactive_style

---@type fun(filter: table): boolean
local process_filter = require("bubbly.utils.module").process_filter

-- Returns bubble that shows current mode
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if not process_filter(settings.filter) then
    return nil
  end
  local mode = vim.fn.mode()
  local data
  local color
  if inactive then
    color = settings.inactive_color
  end
  local style
  if inactive then
    style = settings.inactive_style
  else
    style = settings.style
  end
  if mode == "n" then
    data = settings.tag.normal
    if not inactive then
      color = settings.color.normal
    end
  elseif mode == "i" then
    data = settings.tag.insert
    if not inactive then
      color = settings.color.insert
    end
  elseif mode == "v" or mode == "V" then
    data = settings.tag.visual
    if not inactive then
      color = settings.color.visual
    end
  elseif mode == "^V" or mode == "" then
    data = settings.tag.visualblock
    if not inactive then
      color = settings.color.visualblock
    end
  elseif mode == "c" then
    data = settings.tag.command
    if not inactive then
      color = settings.color.command
    end
  elseif mode == "t" then
    data = settings.tag.terminal
    if not inactive then
      color = settings.color.terminal
    end
  elseif mode == "R" then
    data = settings.tag.replace
    if not inactive then
      color = settings.color.replace
    end
  else
    data = settings.tag.default
    if not inactive then
      color = settings.color.default
    end
  end
  return { { data = data, color = color, style = style } }
end
