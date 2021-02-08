-- ===============
-- FILETYPE BUBBLE
-- ===============
-- Created by datwaft <github.com/datwaft>

local settings = {
   tag = vim.g.bubbly_tags.filetype,
   color = vim.g.bubbly_colors.filetype,
   style = vim.g.bubbly_styles.filetype,
}

if not settings.tag then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load tag configuration for the component 'filetype', the default tag will be used.]]
   settings.tag = vim.g.bubbly_tags.default
end
if not settings.color then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'filetype', the default color will be used.]]
   settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
   require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'filetype', the default style will be used.]]
   settings.style = vim.g.bubbly_styles.default
end

return function(inactive)
   if inactive then return nil end
   local filetype = vim.bo.filetype
   if filetype == '' then filetype = settings.tag.noft
   else filetype = filetype:lower() end
   return {{
      data = filetype,
      color = settings.color,
      style = settings.style,
   }}
end
