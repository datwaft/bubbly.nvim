-- ==================
-- STATUSLINE FACTORY
-- ==================
-- Created by datwaft <github.com/datwaft>

local bubble_factory = require("bubbly.factories.bubble")
local filter = require("bubbly.utils.table").filter

local bubble_separator = vim.g.bubbly_characters.bubble_separator

-- Returns an statusline string from a list of strings
---@param list string[]
---@return string
local construct_statusline = function(list)
  local statusline = ""
  local alignment = "left"
  for i, bubble in ipairs(list) do
    if bubble == "%=" then
      alignment = "right"
      statusline = statusline .. bubble
    elseif bubble == "%<" then
      statusline = statusline .. bubble
    elseif alignment == "left" then
      if i ~= 1 then
        statusline = statusline .. bubble_separator
      end
      statusline = statusline .. bubble
    else
      statusline = statusline .. bubble
      if i ~= #list then
        statusline = statusline .. bubble_separator
      end
    end
  end
  return statusline
end

-- Returns an statusline string following :help 'statusline'
---@param list string[]
---@param inactive boolean
---@return string
return function(list, inactive)
  local statusline = {}
  for _, e in ipairs(list) do
    local type = type(e)
    if type == "table" then
      statusline[#statusline + 1] = bubble_factory(e)
    elseif type == "function" then
      statusline[#statusline + 1] = bubble_factory(e(inactive))
    elseif type == "string" then
      if e:lower() == "divisor" or e:lower() == "division" then
        statusline[#statusline + 1] = "%="
      elseif e:lower() == "truc" or e:lower() == "truncate" then
        statusline[#statusline + 1] = "%<"
      else
        local component = require("bubbly.utils.prerequire")("bubbly.components." .. e:lower())
        if component then
          statusline[#statusline + 1] = bubble_factory(component(inactive))
        end
      end
    end
  end
  statusline = filter(statusline, function(_, e)
    return type(e) == "string" and e ~= ""
  end)
  return construct_statusline(statusline)
end
