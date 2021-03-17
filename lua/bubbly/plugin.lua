-- ====================
-- STATUSLINE DEFINTION
-- ====================
-- Created by datwaft <github.com/datwaft>

-- Returns an statusline string following :help 'statusline'
---@param inactive boolean
---@return string
return function(inactive)
  if inactive and type(inactive) ~= 'boolean' then inactive = true end
  return require'bubbly.factories.statusline'(vim.g.bubbly_statusline, inactive)
end
