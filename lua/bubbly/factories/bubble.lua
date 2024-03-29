-- ==============
-- BUBBLE FACTORY
-- ==============
-- Created by datwaft <github.com/datwaft>

local gethighlight = require("bubbly.utils.highlight").gethighlight

local settings = {
  left_character = vim.g.bubbly_characters.left,
  right_character = vim.g.bubbly_characters.right,
  inactive_color = vim.g.bubbly_inactive_color,
}

---@class Color
---@field foreground string
---@field background string

---@class Segment
---@field data string
---@field color string | Color
---@field style string | nil
---@field pre string | nil
---@field post string | nil
---@field left string | nil
---@field right string | nil

-- Returns a statusline bubble component following :help 'statusline'
---@param list Segment[]
---@return string
return function(list)
  if type(list) ~= "table" then
    return ""
  end
  -- Render delimiter of the bubble
  local function render_delimiter(delimiter, color)
    if type(color) == "string" then
      return "%#" .. gethighlight(nil, color) .. "Delimiter#" .. delimiter
    else
      return "%#" .. gethighlight(color.foreground, color.background) .. "Delimiter#" .. delimiter
    end
  end
  -- Auxiliar function to know if data is last in the list
  ---@param current_index number
  ---@return boolean
  local function is_last(current_index)
    for i = current_index + 1, #list do
      if
        list[i]
        and type(list[i]) == "table"
        and list[i].data
        and type(list[i].data) == "string"
        and list[i].data ~= ""
      then
        return false
      end
    end
    return true
  end
  -- Beginning of function
  local isfirst = true
  local bubble = ""
  for i, e in ipairs(list) do
    if e and type(e) == "table" and e.data and type(e.data) == "string" and e.data ~= "" then
      -- check if element is the last one
      local islast = is_last(i)
      -- normalize style
      if not e.style or type(e.style) ~= "string" then
        e.style = ""
      end
      -- normalize color
      if not e.color or (type(e.color) ~= "string" and type(e.color) ~= "table") then
        e.color = settings.inactive_color
      end
      -- normalize pre
      if not e.pre or type(e.pre) ~= "string" then
        e.pre = ""
      end
      -- normalize post
      if not e.post or type(e.post) ~= "string" then
        e.post = ""
      end
      -- normalize left
      if not e.left or type(e.left) ~= "string" then
        e.left = settings.left_character
      end
      -- normalize right
      if not e.right or type(e.right) ~= "string" then
        e.right = settings.right_character
      end
      -- render pre
      bubble = bubble .. e.pre
      -- render left delimiter
      if isfirst then
        bubble = bubble .. render_delimiter(e.left, e.color)
      end
      -- render data style
      if type(e.color) == "string" then
        bubble = bubble .. "%#" .. gethighlight(nil, e.color, e.style) .. "#"
      else
        bubble = bubble .. "%#" .. gethighlight(e.color.foreground, e.color.background, e.style) .. "#"
      end
      -- render data
      if not isfirst then
        bubble = bubble .. " "
      end
      bubble = bubble .. e.data:gsub("^%s*(.-)%s*$", "%1")
      if not islast then
        bubble = bubble .. " "
      end
      -- render right delimiter
      if islast then
        bubble = bubble .. render_delimiter(e.right, e.color) .. "%#BubblyStatusLine#"
      end
      -- render post
      bubble = bubble .. e.post
      -- disable isfirst
      isfirst = false
    end
  end
  return bubble
end
