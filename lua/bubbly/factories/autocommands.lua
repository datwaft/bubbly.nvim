-- ===================
-- AUTOCOMMAND FACTORY
-- ===================
-- Created by datwaft <github.com/datwaft>

-- ====================
-- Auxiliars definition
-- ====================
   local function processEvents(events)
      local result = ''
      for i, e in ipairs(events) do
         result = result..e
         if i ~= #events then
            result = result..','
         end
      end
      return result
   end
   local function processVariable(variable)
      local result
      if variable.type == 'buffer' then
         result = 'b:'
      elseif variable.type == 'window' then
         result = 'w:'
      elseif variable.type == 'global' then
         result = 'g:'
      else
         result = 'g:'
      end
      result = result..variable.name
      return result
   end
   local function autocmd(autocommand)
      local id = autocommand.variable.name
      _G[id] = autocommand.command
      vim.cmd('autocmd '..processEvents(autocommand.events)..' * let '..processVariable(autocommand.variable)..' = v:lua.'..id..'()')
   end
-- ==================
-- Factory definition
-- ==================
   return function(list)
      for _, e in ipairs(list) do
         local type = type(e)
         if type == 'string' then
            local autocommands = require'bubbly.utils.prerequire'('bubbly.autocommands.'..e:lower())
            if autocommands then
               for _, autocommand in ipairs(autocommands) do
                  autocmd(autocommand)
               end
            end
         end
      end
   end
