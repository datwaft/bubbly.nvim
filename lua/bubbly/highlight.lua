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
    return {autoload("bubbly.lib.cljlib")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {autoload = {clj = "bubbly.lib.cljlib"}}
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
local inc = _local_8_["inc"]
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
return nil