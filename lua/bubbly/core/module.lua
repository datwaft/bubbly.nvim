-- ==================
-- MODULE DECLARATION
-- ==================
-- Created by datwaft <github.com/datwaft>

local Module = {}

function Module.new(name)
  if name == nil then
    name = "UNKOWN"
  end
  local module = {
    name = name,
  }
  setmetatable(module, {
    __index = function(self, key)
      local io = require("bubbly.utils.io")
      io.warning("Tried to index module '" .. self.name .. "' with invalid key '" .. key .. "'")
    end,
  })
  return module
end

return Module
