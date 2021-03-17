-- ============
-- PASTE BUBBLE
-- ============
-- Created by datwaft <github.com/datwaft>

local settings = {
  tag = vim.g.bubbly_tags.paste,
  color = vim.g.bubbly_colors.paste,
  style = vim.g.bubbly_styles.paste,
}

if not settings.tag then
  require'bubbly.utils.io'.warning[[Couldn't load tag configuration for the component 'paste', the default tag will be used.]]
  settings.tag = vim.g.bubbly_tags.default
end
if not settings.color then
  require'bubbly.utils.io'.warning[[Couldn't load color configuration for the component 'paste', the default color will be used.]]
  settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
  require'bubbly.utils.io'.warning[[Couldn't load style configuration for the component 'paste', the default style will be used.]]
  settings.style = vim.g.bubbly_styles.default
end

-- Returns bubble that shows if paste mode is active
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then return nil end
  return {{
    data = vim.o.paste and settings.tag,
    color = settings.color,
    style = settings.style,
  }}
end
