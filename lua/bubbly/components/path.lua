-- ===========
-- PATH BUBBLE
-- ===========
-- Created by datwaft <github.com/datwaft>

local settings = {
  symbol = vim.g.bubbly_symbols.path,
  color = vim.g.bubbly_colors.path,
  inactive_color = vim.g.bubbly_inactive_color,
  style = vim.g.bubbly_styles.path,
  inactive_style = vim.g.bubbly_inactive_style,
}

if not settings.symbol then
  require'bubbly.utils.io'.warning[[Couldn't load symbol configuration for the component 'path', the default symbol will be used.]]
  settings.symbol = vim.g.bubbly_symbols.default
end
if not settings.color then
  require'bubbly.utils.io'.warning[[Couldn't load color configuration for the component 'path', the default color will be used.]]
  settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
  require'bubbly.utils.io'.warning[[Couldn't load style configuration for the component 'path', the default style will be used.]]
  settings.style = vim.g.bubbly_styles.default
end

-- Returns bubble that shows current file path
---@param inactive boolean
---@return Segment[]
return function(inactive)
  return {
    inactive or {
      data = vim.bo.ro and settings.symbol.readonly,
      color = settings.color.readonly,
      style = settings.style.readonly,
    },
    inactive or {
      data = vim.bo.ma or settings.symbol.unmodifiable,
      color = settings.color.unmodifiable,
      style = settings.style.unmodifiable,
    },
    {
      data = '%.30f',
      color = inactive and settings.inactive_color or settings.color.path,
      style = inactive and settings.inactive_style or settings.style.path,
    },
    inactive or {
      data = vim.bo.mod and settings.symbol.modified,
      color = settings.color.modified,
      style = settings.style.modified,
    },
  }
end
