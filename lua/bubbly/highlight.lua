local _2afile_2a = "fnl/bubbly/highlight.fnl"
local _1_
do
  local name_4_auto = "bubbly.highlight"
  local module_5_auto
  do
    local x_6_auto = _G.package.loaded[name_4_auto]
    if ("table" == type(x_6_auto)) then
      module_5_auto = x_6_auto
    else
      module_5_auto = {}
    end
  end
  module_5_auto["aniseed/module"] = name_4_auto
  module_5_auto["aniseed/locals"] = ((module_5_auto)["aniseed/locals"] or {})
  do end (module_5_auto)["aniseed/local-fns"] = ((module_5_auto)["aniseed/local-fns"] or {})
  do end (_G.package.loaded)[name_4_auto] = module_5_auto
  _1_ = module_5_auto
end
local autoload
local function _3_(...)
  return (require("bubbly.aniseed.autoload")).autoload(...)
end
autoload = _3_
local function _6_(...)
  local ok_3f_21_auto, val_22_auto = nil, nil
  local function _5_()
    return {autoload("lib.cljlib")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {autoload = {clj = "lib.cljlib"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local clj = _local_4_[1]
local _2amodule_2a = _1_
local _2amodule_name_2a = "bubbly.highlight"
do local _ = ({nil, _1_, nil, {{}, nil, nil, nil}})[2] end
local _local_8_ = clj
local empty_3f = _local_8_["empty?"]
local inc = _local_8_["inc"]
local nil_3f = _local_8_["nil?"]
local hex__3edec
do
  local v_23_auto
  local function hex__3edec0(hex)
    return tonumber(hex, 16)
  end
  v_23_auto = hex__3edec0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hex->dec"] = v_23_auto
  hex__3edec = v_23_auto
end
local hex__3e8bit
do
  local v_23_auto
  do
    local v_25_auto
    local function hex__3e8bit0(hex)
      local function v2ci(v)
        if (v < 48) then
          return 0
        elseif (v < 115) then
          return 1
        else
          return math.floor(((v - 35) / 40))
        end
      end
      local function dist(_10_, _12_)
        local _arg_11_ = _10_
        local A = _arg_11_[1]
        local B = _arg_11_[2]
        local C = _arg_11_[3]
        local _arg_13_ = _12_
        local a = _arg_13_[1]
        local b = _arg_13_[2]
        local c = _arg_13_[3]
        return (((A - a) ^ 2) + ((B - b) ^ 2) + ((C - c) ^ 2))
      end
      local i2cv = {0, 95, 135, 175, 215, 255}
      local _let_14_ = {string.match(hex, "#(%w%w)(%w%w)(%w%w)")}
      local r = _let_14_[1]
      local g = _let_14_[2]
      local b = _let_14_[3]
      local function _16_()
        local tbl_12_auto = {}
        for _, v in ipairs({r, g, b}) do
          tbl_12_auto[(#tbl_12_auto + 1)] = hex__3edec(v)
        end
        return tbl_12_auto
      end
      local _let_15_ = _16_()
      local r0 = _let_15_[1]
      local g0 = _let_15_[2]
      local b0 = _let_15_[3]
      local ir = v2ci(r0)
      local ig = v2ci(g0)
      local ib = v2ci(b0)
      local color_index = ((36 * ir) + (6 * ig) + ib)
      local average = math.floor(((r0 + g0 + b0) / 3))
      local gray_index
      if (average > 238) then
        gray_index = 23
      else
        gray_index = math.floor(((average - 3) / 10))
      end
      local cr = (i2cv)[inc(ir)]
      local cg = (i2cv)[inc(ig)]
      local cb = (i2cv)[inc(ib)]
      local gv = (8 + (gray_index * 10))
      local color_error = dist({cr, cg, cb}, {r0, g0, b0})
      local gray_error = dist({gv, gv, gv}, {r0, g0, b0})
      if (color_error <= gray_error) then
        return (16 + color_index)
      else
        return (232 + gray_index)
      end
    end
    v_25_auto = hex__3e8bit0
    _1_["hex->8bit"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hex->8bit"] = v_23_auto
  hex__3e8bit = v_23_auto
end
local __3ebool
do
  local v_23_auto
  local function __3ebool0(obj)
    if obj then
      return true
    else
      return false
    end
  end
  v_23_auto = __3ebool0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["->bool"] = v_23_auto
  __3ebool = v_23_auto
end
local hex_color_3f
do
  local v_23_auto
  local function hex_color_3f0(hex_color)
    return __3ebool(string.match(hex_color, "#%w%w%w%w%w%w"))
  end
  v_23_auto = hex_color_3f0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hex-color?"] = v_23_auto
  hex_color_3f = v_23_auto
end
local extract_highlight_by_name
do
  local v_23_auto
  local function extract_highlight_by_name0(group_name)
    local ok_3f, value = pcall(vim.api.nvim_get_hl_by_name, group_name, true)
    if ok_3f then
      return value
    end
  end
  v_23_auto = extract_highlight_by_name0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["extract-highlight-by-name"] = v_23_auto
  extract_highlight_by_name = v_23_auto
end
local extract_color
do
  local v_23_auto
  local function extract_color0(color)
    local _21_ = {string.match(color, "(%w+)%s(%w+)")}
    if ((type(_21_) == "table") and (nil ~= (_21_)[1]) and (nil ~= (_21_)[2])) then
      local group_name = (_21_)[1]
      local key = (_21_)[2]
      local function _25_()
        local _22_
        do
          local _23_ = extract_highlight_by_name(group_name)
          if _23_ then
            _22_ = (_23_)[key]
          else
            _22_ = _23_
          end
        end
        if _22_ then
          return string.format("#%06x", _22_)
        else
          return _22_
        end
      end
      return (_25_() or "NONE")
    else
      local _ = _21_
      return color
    end
  end
  v_23_auto = extract_color0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["extract-color"] = v_23_auto
  extract_color = v_23_auto
end
local highlight
do
  local v_23_auto
  do
    local v_25_auto
    local function highlight0(group_name, _28_, attr_list)
      local _arg_29_ = _28_
      local guibg = _arg_29_["bg"]
      local guifg = _arg_29_["fg"]
      local attr_list0
      if (nil_3f(attr_list) or empty_3f(attr_list)) then
        attr_list0 = "NONE"
      else
        attr_list0 = table.concat(attr_list, ",")
      end
      local guifg0 = extract_color(guifg)
      local guibg0 = extract_color(guibg)
      local ctermfg
      if hex_color_3f(guifg0) then
        ctermfg = hex__3e8bit(guifg0)
      else
        ctermfg = guifg0
      end
      local ctermbg
      if hex_color_3f(guibg0) then
        ctermbg = hex__3e8bit(guibg0)
      else
        ctermbg = guibg0
      end
      return string.format("highlight %s ctermfg=%s ctermbg=%s cterm=%s guifg=%s guibg=%s gui=%s", group_name, ctermfg, ctermbg, attr_list0, guifg0, guibg0, attr_list0)
    end
    v_25_auto = highlight0
    _1_["highlight"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["highlight"] = v_23_auto
  highlight = v_23_auto
end
return nil