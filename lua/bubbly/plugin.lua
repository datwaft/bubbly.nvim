-- ==================
-- BUBBLY.NVIM PLUGIN
-- ==================
-- Created by: datwaft [github.com/datwaft]

-- ==========
-- Definition
-- ==========
   return function(inactive)
      if inactive and type(inactive) ~= 'boolean' then inactive = true end
      return require'bubbly.factories.statusline'(vim.g.bubbly_statusline, inactive)
   end
