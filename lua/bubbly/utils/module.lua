-- ============
-- MODULE UTILS
-- ============
-- Created by datwaft <github.com/datwaft>

local M = require'bubbly.core.module'.new('utils.module')

local io = require'bubbly.utils.io'
local split = require'bubbly.utils.string'.split

-- Checks if current filetype is in the filter list
-- If it returns false the component should return nil
---@param filter table
---@return boolean
function M.process_filter(filter)
  if filter == nil then return true end
  local filetype = vim.bo.filetype
  for _, value in ipairs(filter) do
    if filetype == value then
      if filter.mode == 'blacklist' then
        return false
      elseif filter.mode == 'whitelist' then
        return true
      else
        io.warning'A filter has an invalid mode, it will show the component'
        return true
      end
    end
  end
end

-- Gets value in the depths of a table by a key separated by '.'
-- e.g. key = 'x.y.z' -> table.x.y.z
---@param table table
---@param key string
---@return any
local function get_value(table, key)
  local current = table
  local keys = split(key, '.')
  dump(keys)
  for _, v in ipairs(keys) do
    current = current[v]
    if current == nil then return nil end
  end
  return current
end

-- Processes the settings
-- If the setting for the module is nil then it will become the default value
---@param settings table
---@param module_name string
function M.process_settings(settings, module_name)
  local processed_settings = {}
  for key, setting in pairs(settings) do
    if type(setting) == 'table' then
      if setting[module_name] == nil then
        processed_settings[key] = setting.default
      else
        processed_settings[key] = get_value(setting, module_name)
      end
    else
      processed_settings[key] = setting
    end
  end
  return processed_settings
end

return M
