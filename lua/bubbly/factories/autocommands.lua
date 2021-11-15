-- ===================
-- AUTOCOMMAND FACTORY
-- ===================
-- Created by datwaft <github.com/datwaft>

-- Concatenates events with a ','
-- e.g. { 'Event1', 'Event2' } -> 'Event1,Event2'
---@param events string[]
---@return string
local function processEvents(events)
  local result = ""
  for i, e in ipairs(events) do
    result = result .. e
    if i ~= #events then
      result = result .. ","
    end
  end
  return result
end

---@class Variable
---@field type 'buffer' | 'window' | 'global'
---@field name string

-- Generates variable name from Variable object
-- e.g. { name = 'name', type = 'global' } -> 'g:variable'
---@param variable Variable
---@return string
local function processVariable(variable)
  local result
  if variable.type == "buffer" then
    result = "b:"
  elseif variable.type == "window" then
    result = "w:"
  elseif variable.type == "global" then
    result = "g:"
  else
    result = "g:"
  end
  result = result .. variable.name
  return result
end

---@class Autocommand
---@field events string[]
---@field variable Variable
---@field command fun(): any

-- Executes vim autocommand command following :help autocmd that saves the result of a function in a variable
---@param autocommand Autocommand
local function autocmd(autocommand)
  local id = autocommand.variable.name
  _G[id] = autocommand.command
  vim.cmd(
    "autocmd "
      .. processEvents(autocommand.events)
      .. " * let "
      .. processVariable(autocommand.variable)
      .. " = v:lua."
      .. id
      .. "()"
  )
end

-- Executes every autocommand in the list of names of modules that are autocommands
---@param list string[]
return function(list)
  for _, e in ipairs(list) do
    local type = type(e)
    if type == "string" then
      ---@type Autocommand[]
      local autocommands = require("bubbly.utils.prerequire")("bubbly.autocommands." .. e:lower())
      if autocommands then
        for _, autocommand in ipairs(autocommands) do
          autocmd(autocommand)
        end
      end
    end
  end
end
