-- =================
-- HIGHLIGHT FACTORY
-- =================
-- Created by datwaft <github.com/datwaft>

local titlecase = require("bubbly.utils.string").titlecase
local highlight = require("bubbly.utils.highlight").highlight
local hlparser = require("bubbly.utils.highlight").hlparser

-- Executes highlight vim command
---@param name string
---@param foreground string
---@param background string
---@param style string | nil
local function execute_command(name, foreground, background, style)
  vim.cmd(highlight(name, foreground, background, style))
end

-- Creates highlight config to be used in global highlight cache
---@param command string - vim highlight command
local function highlight_config(command)
  return { exists = false, cmd = command }
end

-- Returns highlight configs wrapping vim commands for normal, bold, italic and
-- delimiter highlight
---@param name string
---@param foreground string
---@param background string
---@param default_background string
local function define_bubble_highlight(name, foreground, background, default_background)
  return {
    [name] = highlight_config(highlight(name, background, foreground)),
    [name .. "Bold"] = highlight_config(highlight(name .. "Bold", background, foreground, "bold")),
    [name .. "Italic"] = highlight_config(highlight(name .. "Italic", background, foreground, "italic")),
    [name .. "Delimiter"] = highlight_config(highlight(name .. "Delimiter", foreground, default_background)),
  }
end

-- Generates all vim highlight configs following :help :highlight for a palette
-- and saves them in a global variable
---@param palette table<string, string>
return function(palette)
  local fg = hlparser(palette.foreground)
  local bg = hlparser(palette.background)
  local highlights = {}
  for k1, v1 in pairs(palette) do
    v1 = hlparser(v1)
    for k2, v2 in pairs(palette) do
      if k1 ~= k2 then
        v2 = hlparser(v2)
        local name = "Bubbly" .. titlecase(k2) .. titlecase(k1)
        local bubble_highlights = define_bubble_highlight(name, v1, v2, bg)
        highlights = vim.tbl_extend("force", highlights, bubble_highlights)
      end
    end
    if k1 ~= "background" then
      local bubble_highlights = define_bubble_highlight("Bubbly" .. titlecase(k1), v1, bg, bg)
      highlights = vim.tbl_extend("force", highlights, bubble_highlights)
    end
  end
  highlights["BubblyStatusLine"] = highlight_config(highlight("BubblyStatusLine", fg, bg))
  execute_command("BubblyTabLine", fg, bg)
  vim.g._bubbly_highlight_cache = highlights
end
