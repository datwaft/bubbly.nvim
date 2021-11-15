-- ======================
-- HIGHTLIGHTS DEFINITION
-- ======================
-- Created by datwaft <github.com/datwaft>

-- Defines vim highlights used in the statusline
return function()
  local highlight_factory = require("bubbly.factories.highlight")
  highlight_factory(vim.g.bubbly_palette)
end
