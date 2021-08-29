local _2afile_2a = "fnl/bubbly/lib/cljlib/init.fnl"
local module_info = {_DESCRIPTION = "Fennel-cljlib - functions from Clojure's core.clj implemented on top\nof Fennel.\n\nThis library contains a set of functions providing functions that\nbehave similarly to Clojure's equivalents.  Library itself has nothing\nFennel specific so it should work on Lua, e.g:\n\n``` lua\nLua 5.3.5  Copyright (C) 1994-2018 Lua.org, PUC-Rio\n> clj = require\"cljlib\"\n> table.concat(clj.mapv(function (x) return x * x end, {1, 2, 3}), \" \")\n-- 1 4 9\n```\n\nThis example is mapping an anonymous `function' over a table,\nproducing new table and concatenating it with `\" \"`.\n\nHowever this library also provides Fennel-specific set of\n[macros](./macros.md), that provides additional facilities like\n`defn' or `defmulti' which extend the language allowing writing code\nthat looks and works mostly like Clojure.\n\nEach function in this library is created with `defn', which is a\nspecial macros for creating multi-arity functions.  So when you see\nfunction signature like `(foo [x])`, this means that this is function\n`foo', that accepts exactly one argument `x'.  In contrary, functions\ncreated with `fn' will produce `(foo x)` signature (`x' is not inside\nbrackets).\n\nFunctions, which signatures look like `(foo ([x]) ([x y]) ([x y &\nzs]))`, it is a multi-arity function, which accepts either one, two,\nor three-or-more arguments.  Each `([...])` represents different body\nof a function which is chosen by checking amount of arguments passed\nto the function.  See [Clojure's doc section on multi-arity\nfunctions](https://clojure.org/guides/learn/functions#_multi_arity_functions).\n\n## Compatibility\nThis library is mainly developed with Lua 5.4, and tested against\nLua 5.2, 5.3, 5.4, and LuaJIT 2.1.0-beta3.  Note, that in lua 5.2 and\nLuaJIT equality semantics are a bit different from Lua 5.3 and Lua 5.4.\nMain difference is that when comparing two tables, they must have\nexactly the same `__eq` metamethods, so comparing hash sets with hash\nsets will work, but comparing sets with other tables works only in\nLua5.3+.  Another difference is that Lua 5.2 and LuaJIT don't have\ninbuilt UTF-8 library, therefore `seq' function will not work for\nnon-ASCII strings.", _MODULE_NAME = "cljlib"}
local core = {}
local insert = table.insert
local _unpack = (table.unpack or _G.unpack)
local apply
do
  local function apply0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 2) then
      local _let_1_ = {...}
      local f = _let_1_[1]
      local args = _let_1_[2]
      return f(_unpack(args))
    elseif (len_77_auto == 3) then
      local _let_2_ = {...}
      local f = _let_2_[1]
      local a = _let_2_[2]
      local args = _let_2_[3]
      return f(a, _unpack(args))
    elseif (len_77_auto == 4) then
      local _let_3_ = {...}
      local f = _let_3_[1]
      local a = _let_3_[2]
      local b = _let_3_[3]
      local args = _let_3_[4]
      return f(a, b, _unpack(args))
    elseif (len_77_auto == 5) then
      local _let_4_ = {...}
      local f = _let_4_[1]
      local a = _let_4_[2]
      local b = _let_4_[3]
      local c = _let_4_[4]
      local args = _let_4_[5]
      return f(a, b, c, _unpack(args))
    elseif (len_77_auto >= 5) then
      local _let_5_ = {...}
      local f = _let_5_[1]
      local a = _let_5_[2]
      local b = _let_5_[3]
      local c = _let_5_[4]
      local d = _let_5_[5]
      local args = {(table.unpack or unpack)(_let_5_, 6)}
      local flat_args = setmetatable({}, {["cljlib/type"] = "seq"})
      for i = 1, (#args - 1) do
        insert(flat_args, args[i])
      end
      for _, a0 in ipairs(args[#args]) do
        insert(flat_args, a0)
      end
      return f(a, b, c, d, _unpack(flat_args))
    else
      return error("wrong argument amount for apply", 2)
    end
  end
  core.apply = apply0
  local value_37_auto = core.apply
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"\n  ([f args])", "\n  ([f a args])", "\n  ([f a b args])", "\n  ([f a b c args])", "\n  ([f a b c d & args])"}, ["fnl/docstring"] = "Apply `f' to the argument list formed by prepending intervening\narguments to `args', and `f' must support variadic amount of\narguments.\n\n# Examples\nApplying `add' to different amount of arguments:\n\n``` fennel\n(assert-eq (apply add [1 2 3 4]) 10)\n(assert-eq (apply add 1 [2 3 4]) 10)\n(assert-eq (apply add 1 2 3 4 5 6 [7 8 9]) 45)\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  apply = value_37_auto
end
local add
do
  local function add0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 0) then
      local _let_8_ = {...}
      return 0
    elseif (len_77_auto == 1) then
      local _let_9_ = {...}
      local a = _let_9_[1]
      return a
    elseif (len_77_auto == 2) then
      local _let_10_ = {...}
      local a = _let_10_[1]
      local b = _let_10_[2]
      return (a + b)
    elseif (len_77_auto == 3) then
      local _let_11_ = {...}
      local a = _let_11_[1]
      local b = _let_11_[2]
      local c = _let_11_[3]
      return (a + b + c)
    elseif (len_77_auto == 4) then
      local _let_12_ = {...}
      local a = _let_12_[1]
      local b = _let_12_[2]
      local c = _let_12_[3]
      local d = _let_12_[4]
      return (a + b + c + d)
    elseif (len_77_auto >= 4) then
      local _let_13_ = {...}
      local a = _let_13_[1]
      local b = _let_13_[2]
      local c = _let_13_[3]
      local d = _let_13_[4]
      local rest = {(table.unpack or unpack)(_let_13_, 5)}
      return apply(add0, (a + b + c + d), rest)
    end
  end
  core.add = add0
  local value_37_auto = core.add
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([a])", "([a b])", "([a b c])", "([a b c d])", "([a b c d & rest])"}, ["fnl/docstring"] = "Sum arbitrary amount of numbers."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  add = value_37_auto
end
local sub
do
  local function sub0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 0) then
      local _let_16_ = {...}
      return 0
    elseif (len_77_auto == 1) then
      local _let_17_ = {...}
      local a = _let_17_[1]
      return ( - a)
    elseif (len_77_auto == 2) then
      local _let_18_ = {...}
      local a = _let_18_[1]
      local b = _let_18_[2]
      return (a - b)
    elseif (len_77_auto == 3) then
      local _let_19_ = {...}
      local a = _let_19_[1]
      local b = _let_19_[2]
      local c = _let_19_[3]
      return (a - b - c)
    elseif (len_77_auto == 4) then
      local _let_20_ = {...}
      local a = _let_20_[1]
      local b = _let_20_[2]
      local c = _let_20_[3]
      local d = _let_20_[4]
      return (a - b - c - d)
    elseif (len_77_auto >= 4) then
      local _let_21_ = {...}
      local a = _let_21_[1]
      local b = _let_21_[2]
      local c = _let_21_[3]
      local d = _let_21_[4]
      local rest = {(table.unpack or unpack)(_let_21_, 5)}
      return apply(sub0, (a - b - c - d), rest)
    end
  end
  core.sub = sub0
  local value_37_auto = core.sub
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([a])", "([a b])", "([a b c])", "([a b c d])", "([a b c d & rest])"}, ["fnl/docstring"] = "Subtract arbitrary amount of numbers."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  sub = value_37_auto
end
local mul
do
  local function mul0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 0) then
      local _let_24_ = {...}
      return 1
    elseif (len_77_auto == 1) then
      local _let_25_ = {...}
      local a = _let_25_[1]
      return a
    elseif (len_77_auto == 2) then
      local _let_26_ = {...}
      local a = _let_26_[1]
      local b = _let_26_[2]
      return (a * b)
    elseif (len_77_auto == 3) then
      local _let_27_ = {...}
      local a = _let_27_[1]
      local b = _let_27_[2]
      local c = _let_27_[3]
      return (a * b * c)
    elseif (len_77_auto == 4) then
      local _let_28_ = {...}
      local a = _let_28_[1]
      local b = _let_28_[2]
      local c = _let_28_[3]
      local d = _let_28_[4]
      return (a * b * c * d)
    elseif (len_77_auto >= 4) then
      local _let_29_ = {...}
      local a = _let_29_[1]
      local b = _let_29_[2]
      local c = _let_29_[3]
      local d = _let_29_[4]
      local rest = {(table.unpack or unpack)(_let_29_, 5)}
      return apply(mul0, (a * b * c * d), rest)
    end
  end
  core.mul = mul0
  local value_37_auto = core.mul
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([a])", "([a b])", "([a b c])", "([a b c d])", "([a b c d & rest])"}, ["fnl/docstring"] = "Multiply arbitrary amount of numbers."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  mul = value_37_auto
end
local div
do
  local function div0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 1) then
      local _let_32_ = {...}
      local a = _let_32_[1]
      return (1 / a)
    elseif (len_77_auto == 2) then
      local _let_33_ = {...}
      local a = _let_33_[1]
      local b = _let_33_[2]
      return (a / b)
    elseif (len_77_auto == 3) then
      local _let_34_ = {...}
      local a = _let_34_[1]
      local b = _let_34_[2]
      local c = _let_34_[3]
      return (a / b / c)
    elseif (len_77_auto == 4) then
      local _let_35_ = {...}
      local a = _let_35_[1]
      local b = _let_35_[2]
      local c = _let_35_[3]
      local d = _let_35_[4]
      return (a / b / c / d)
    elseif (len_77_auto >= 4) then
      local _let_36_ = {...}
      local a = _let_36_[1]
      local b = _let_36_[2]
      local c = _let_36_[3]
      local d = _let_36_[4]
      local rest = {(table.unpack or unpack)(_let_36_, 5)}
      return apply(div0, (a / b / c / d), rest)
    else
      return error("wrong argument amount for div", 2)
    end
  end
  core.div = div0
  local value_37_auto = core.div
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b c])", "([a b c d])", "([a b c d & rest])"}, ["fnl/docstring"] = "Divide arbitrary amount of numbers."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  div = value_37_auto
end
local le
do
  local function le0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 1) then
      local _let_39_ = {...}
      local a = _let_39_[1]
      return true
    elseif (len_77_auto == 2) then
      local _let_40_ = {...}
      local a = _let_40_[1]
      local b = _let_40_[2]
      return (a <= b)
    elseif (len_77_auto >= 2) then
      local _let_41_ = {...}
      local a = _let_41_[1]
      local b = _let_41_[2]
      local _let_42_ = {(table.unpack or unpack)(_let_41_, 3)}
      local c = _let_42_[1]
      local d = _let_42_[2]
      local more = {(table.unpack or unpack)(_let_42_, 3)}
      if (a <= b) then
        if d then
          return apply(le0, b, c, d, more)
        else
          return (b <= c)
        end
      else
        return false
      end
    else
      return error("wrong argument amount for le", 2)
    end
  end
  core.le = le0
  local value_37_auto = core.le
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b & [c d & more]])"}, ["fnl/docstring"] = "Returns true if nums are in monotonically non-decreasing order"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  le = value_37_auto
end
local lt
do
  local function lt0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 1) then
      local _let_47_ = {...}
      local a = _let_47_[1]
      return true
    elseif (len_77_auto == 2) then
      local _let_48_ = {...}
      local a = _let_48_[1]
      local b = _let_48_[2]
      return (a < b)
    elseif (len_77_auto >= 2) then
      local _let_49_ = {...}
      local a = _let_49_[1]
      local b = _let_49_[2]
      local _let_50_ = {(table.unpack or unpack)(_let_49_, 3)}
      local c = _let_50_[1]
      local d = _let_50_[2]
      local more = {(table.unpack or unpack)(_let_50_, 3)}
      if (a < b) then
        if d then
          return apply(lt0, b, c, d, more)
        else
          return (b < c)
        end
      else
        return false
      end
    else
      return error("wrong argument amount for lt", 2)
    end
  end
  core.lt = lt0
  local value_37_auto = core.lt
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b & [c d & more]])"}, ["fnl/docstring"] = "Returns true if nums are in monotonically decreasing order"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  lt = value_37_auto
end
local ge
do
  local function ge0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 1) then
      local _let_55_ = {...}
      local a = _let_55_[1]
      return true
    elseif (len_77_auto == 2) then
      local _let_56_ = {...}
      local a = _let_56_[1]
      local b = _let_56_[2]
      return (a >= b)
    elseif (len_77_auto >= 2) then
      local _let_57_ = {...}
      local a = _let_57_[1]
      local b = _let_57_[2]
      local _let_58_ = {(table.unpack or unpack)(_let_57_, 3)}
      local c = _let_58_[1]
      local d = _let_58_[2]
      local more = {(table.unpack or unpack)(_let_58_, 3)}
      if (a >= b) then
        if d then
          return apply(ge0, b, c, d, more)
        else
          return (b >= c)
        end
      else
        return false
      end
    else
      return error("wrong argument amount for ge", 2)
    end
  end
  core.ge = ge0
  local value_37_auto = core.ge
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b & [c d & more]])"}, ["fnl/docstring"] = "Returns true if nums are in monotonically non-increasing order"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  ge = value_37_auto
end
local gt
do
  local function gt0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 1) then
      local _let_63_ = {...}
      local a = _let_63_[1]
      return true
    elseif (len_77_auto == 2) then
      local _let_64_ = {...}
      local a = _let_64_[1]
      local b = _let_64_[2]
      return (a > b)
    elseif (len_77_auto >= 2) then
      local _let_65_ = {...}
      local a = _let_65_[1]
      local b = _let_65_[2]
      local _let_66_ = {(table.unpack or unpack)(_let_65_, 3)}
      local c = _let_66_[1]
      local d = _let_66_[2]
      local more = {(table.unpack or unpack)(_let_66_, 3)}
      if (a > b) then
        if d then
          return apply(gt0, b, c, d, more)
        else
          return (b > c)
        end
      else
        return false
      end
    else
      return error("wrong argument amount for gt", 2)
    end
  end
  core.gt = gt0
  local value_37_auto = core.gt
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b & [c d & more]])"}, ["fnl/docstring"] = "Returns true if nums are in monotonically increasing order"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  gt = value_37_auto
end
local inc
do
  local function inc0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_71_ = {...}
      local x = _let_71_[1]
      return (x + 1)
    else
      return error("wrong argument amount for inc", 2)
    end
  end
  core.inc = inc0
  local value_37_auto = core.inc
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Increase number `x' by one"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  inc = value_37_auto
end
local dec
do
  local function dec0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_74_ = {...}
      local x = _let_74_[1]
      return (x - 1)
    else
      return error("wrong argument amount for dec", 2)
    end
  end
  core.dec = dec0
  local value_37_auto = core.dec
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Decrease number `x' by one"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  dec = value_37_auto
end
local utility_doc_order = {"apply", "add", "sub", "mul", "div", "le", "lt", "ge", "gt", "inc", "dec"}
local function fast_table_type(tbl)
  local _77_ = tbl
  if _77_ then
    local _78_ = getmetatable(_77_)
    if _78_ then
      return (_78_)["cljlib/type"]
    else
      return _78_
    end
  else
    return _77_
  end
end
local map_3f
do
  local function map_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_81_ = {...}
      local tbl = _let_81_[1]
      if (type(tbl) == "table") then
        local tmp_94_auto = fast_table_type(tbl)
        if tmp_94_auto then
          local t = tmp_94_auto
          return (t == "table")
        else
          local k, _ = next(tbl)
          return ((k ~= nil) and (k ~= 1))
        end
      end
    else
      return error("wrong argument amount for map?", 2)
    end
  end
  core["map?"] = map_3f0
  local value_37_auto = core["map?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Check whether `tbl' is an associative table.\n\nNon empty associative tables are tested for two things:\n- `next' returns the key-value pair,\n- key, that is returned by the `next' is not equal to `1`.\n\nEmpty tables can't be analyzed with this method, and `map?' will\nreturn `false'.  If you need this test pass for empty table, see\n`hash-map' for creating tables that have additional\nmetadata attached for this test to work.\n\n# Examples\nNon empty tables:\n\n``` fennel\n(assert-is (map? {:a 1 :b 2}))\n\n(local some-table {:key :value})\n(assert-is (map? some-table))\n```\n\nEmpty tables:\n\n``` fennel\n(local some-table {})\n(assert-not (map? some-table))\n```\n\nEmpty tables created with `hash-map' will pass the test:\n\n``` fennel\n(local some-table (hash-map))\n(assert-is (map? some-table))\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  map_3f = value_37_auto
end
local vector_3f
do
  local function vector_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_86_ = {...}
      local tbl = _let_86_[1]
      if (type(tbl) == "table") then
        local tmp_94_auto = fast_table_type(tbl)
        if tmp_94_auto then
          local t = tmp_94_auto
          return (t == "seq")
        else
          local k, _ = next(tbl)
          return ((k ~= nil) and (k == 1))
        end
      end
    else
      return error("wrong argument amount for vector?", 2)
    end
  end
  core["vector?"] = vector_3f0
  local value_37_auto = core["vector?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Check whether `tbl' is an sequential table.\n\nNon empty sequential tables are tested for two things:\n- `next' returns the key-value pair,\n- key, that is returned by the `next' is equal to `1`.\n\nEmpty tables can't be analyzed with this method, and `vector?' will\nalways return `false'.  If you need this test pass for empty table,\nsee `vector' for creating tables that have additional\nmetadata attached for this test to work.\n\n# Examples\nNon empty vector:\n\n``` fennel\n(assert-is (vector? [1 2 3 4]))\n\n(local some-table [1 2 3])\n(assert-is (vector? some-table))\n```\n\nEmpty tables:\n\n``` fennel\n(local some-table [])\n(assert-not (vector? some-table))\n```\n\nEmpty tables created with `vector' will pass the test:\n\n``` fennel\n(local some-table (vector))\n(assert-is (vector? some-table))\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  vector_3f = value_37_auto
end
local multifn_3f
do
  local function multifn_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_91_ = {...}
      local mf = _let_91_[1]
      return (((getmetatable(mf) or {}))["cljlib/type"] == "multifn")
    else
      return error("wrong argument amount for multifn?", 2)
    end
  end
  core["multifn?"] = multifn_3f0
  local value_37_auto = core["multifn?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[mf]"}, ["fnl/docstring"] = "Test if `mf' is an instance of `multifn'.\n\n`multifn' is a special kind of table, created with `defmulti' macros\nfrom `macros.fnl'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  multifn_3f = value_37_auto
end
local set_3f
do
  local function set_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_94_ = {...}
      local s = _let_94_[1]
      local _95_ = ((getmetatable(s) or {}))["cljlib/type"]
      if (_95_ == "cljlib/ordered-set") then
        return "cljlib/ordered-set"
      elseif (_95_ == "cljlib/hash-set") then
        return "cljlib/hash-set"
      else
        local _ = _95_
        return false
      end
    else
      return error("wrong argument amount for set?", 2)
    end
  end
  core["set?"] = set_3f0
  local value_37_auto = core["set?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[s]"}, ["fnl/docstring"] = "Test if `s` is either instance of a `hash-set' or `ordered-set'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  set_3f = value_37_auto
end
local nil_3f
do
  local function nil_3f0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 0) then
      local _let_99_ = {...}
      return true
    elseif (len_77_auto == 1) then
      local _let_100_ = {...}
      local x = _let_100_[1]
      return (x == nil)
    else
      return error("wrong argument amount for nil?", 2)
    end
  end
  core["nil?"] = nil_3f0
  local value_37_auto = core["nil?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([x])"}, ["fnl/docstring"] = "Test if `x' is nil."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  nil_3f = value_37_auto
end
local zero_3f
do
  local function zero_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_103_ = {...}
      local x = _let_103_[1]
      return (x == 0)
    else
      return error("wrong argument amount for zero?", 2)
    end
  end
  core["zero?"] = zero_3f0
  local value_37_auto = core["zero?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is equal to zero."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  zero_3f = value_37_auto
end
local pos_3f
do
  local function pos_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_106_ = {...}
      local x = _let_106_[1]
      return (x > 0)
    else
      return error("wrong argument amount for pos?", 2)
    end
  end
  core["pos?"] = pos_3f0
  local value_37_auto = core["pos?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is greater than zero."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  pos_3f = value_37_auto
end
local neg_3f
do
  local function neg_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_109_ = {...}
      local x = _let_109_[1]
      return (x < 0)
    else
      return error("wrong argument amount for neg?", 2)
    end
  end
  core["neg?"] = neg_3f0
  local value_37_auto = core["neg?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is less than zero."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  neg_3f = value_37_auto
end
local even_3f
do
  local function even_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_112_ = {...}
      local x = _let_112_[1]
      return ((x % 2) == 0)
    else
      return error("wrong argument amount for even?", 2)
    end
  end
  core["even?"] = even_3f0
  local value_37_auto = core["even?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is even."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  even_3f = value_37_auto
end
local odd_3f
do
  local function odd_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_115_ = {...}
      local x = _let_115_[1]
      return not even_3f(x)
    else
      return error("wrong argument amount for odd?", 2)
    end
  end
  core["odd?"] = odd_3f0
  local value_37_auto = core["odd?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is odd."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  odd_3f = value_37_auto
end
local string_3f
do
  local function string_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_118_ = {...}
      local x = _let_118_[1]
      return (type(x) == "string")
    else
      return error("wrong argument amount for string?", 2)
    end
  end
  core["string?"] = string_3f0
  local value_37_auto = core["string?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a string."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  string_3f = value_37_auto
end
local boolean_3f
do
  local function boolean_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_121_ = {...}
      local x = _let_121_[1]
      return (type(x) == "boolean")
    else
      return error("wrong argument amount for boolean?", 2)
    end
  end
  core["boolean?"] = boolean_3f0
  local value_37_auto = core["boolean?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a Boolean"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  boolean_3f = value_37_auto
end
local true_3f
do
  local function true_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_124_ = {...}
      local x = _let_124_[1]
      return (x == true)
    else
      return error("wrong argument amount for true?", 2)
    end
  end
  core["true?"] = true_3f0
  local value_37_auto = core["true?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is `true'"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  true_3f = value_37_auto
end
local false_3f
do
  local function false_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_127_ = {...}
      local x = _let_127_[1]
      return (x == false)
    else
      return error("wrong argument amount for false?", 2)
    end
  end
  core["false?"] = false_3f0
  local value_37_auto = core["false?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is `false'"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  false_3f = value_37_auto
end
local int_3f
do
  local function int_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_130_ = {...}
      local x = _let_130_[1]
      return ((type(x) == "number") and (x == math.floor(x)))
    else
      return error("wrong argument amount for int?", 2)
    end
  end
  core["int?"] = int_3f0
  local value_37_auto = core["int?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a number without floating point data.\n\nNumber is rounded with `math.floor' and compared with original number."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  int_3f = value_37_auto
end
local pos_int_3f
do
  local function pos_int_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_133_ = {...}
      local x = _let_133_[1]
      return (int_3f(x) and pos_3f(x))
    else
      return error("wrong argument amount for pos-int?", 2)
    end
  end
  core["pos-int?"] = pos_int_3f0
  local value_37_auto = core["pos-int?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a positive integer."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  pos_int_3f = value_37_auto
end
local neg_int_3f
do
  local function neg_int_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_136_ = {...}
      local x = _let_136_[1]
      return (int_3f(x) and neg_3f(x))
    else
      return error("wrong argument amount for neg-int?", 2)
    end
  end
  core["neg-int?"] = neg_int_3f0
  local value_37_auto = core["neg-int?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a negative integer."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  neg_int_3f = value_37_auto
end
local double_3f
do
  local function double_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_139_ = {...}
      local x = _let_139_[1]
      return ((type(x) == "number") and (x ~= math.floor(x)))
    else
      return error("wrong argument amount for double?", 2)
    end
  end
  core["double?"] = double_3f0
  local value_37_auto = core["double?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a number with floating point data."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  double_3f = value_37_auto
end
local empty_3f
do
  local function empty_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_142_ = {...}
      local x = _let_142_[1]
      local _143_ = type(x)
      if (_143_ == "table") then
        return (next(x) == nil)
      elseif (_143_ == "string") then
        return (x == "")
      else
        local _ = _143_
        return error("empty?: unsupported collection")
      end
    else
      return error("wrong argument amount for empty?", 2)
    end
  end
  core["empty?"] = empty_3f0
  local value_37_auto = core["empty?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Check if collection is empty."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  empty_3f = value_37_auto
end
local not_empty
do
  local function not_empty0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_147_ = {...}
      local x = _let_147_[1]
      if not empty_3f(x) then
        return x
      end
    else
      return error("wrong argument amount for not-empty", 2)
    end
  end
  core["not-empty"] = not_empty0
  local value_37_auto = core["not-empty"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "If `x' is empty, returns `nil', otherwise `x'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  not_empty = value_37_auto
end
local predicate_doc_order = {"map?", "vector?", "multifn?", "set?", "nil?", "zero?", "pos?", "neg?", "even?", "odd?", "string?", "boolean?", "true?", "false?", "int?", "pos-int?", "neg-int?", "double?", "empty?", "not-empty"}
local vector
do
  local function vector0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto >= 0) then
      local _let_151_ = {...}
      local args = {(table.unpack or unpack)(_let_151_, 1)}
      return setmetatable(args, {["cljlib/type"] = "seq"})
    end
  end
  core.vector = vector0
  local value_37_auto = core.vector
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[&", "args]"}, ["fnl/docstring"] = "Constructs sequential table out of it's arguments.\n\nSets additional metadata for function `vector?' to work.\n\n# Examples\n\n``` fennel\n(local v (vector 1 2 3 4))\n(assert-eq v [1 2 3 4])\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  vector = value_37_auto
end
local seq
do
  local function seq0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_154_ = {...}
      local col = _let_154_[1]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      local _155_ = type(col)
      if (_155_ == "table") then
        local m = (getmetatable(col) or {})
        local tmp_108_auto = (m["cljlib/next"] or next)(col)
        if (tmp_108_auto == nil) then
          return nil
        else
          local _ = tmp_108_auto
          local assoc_3f = false
          local assoc_res = setmetatable({}, {["cljlib/type"] = "seq"})
          for k, v in pairs(col) do
            if (not assoc_3f and map_3f(col)) then
              assoc_3f = true
            end
            insert(res, v)
            insert(assoc_res, {k, v})
          end
          if assoc_3f then
            return assoc_res
          else
            return res
          end
        end
      elseif (_155_ == "string") then
        if _G.utf8 then
          local char = _G.utf8.char
          for _, b in _G.utf8.codes(col) do
            insert(res, char(b))
          end
          return res
        else
          do end (io.stderr):write("WARNING: utf8 module unavailable, seq function will not work for non-unicode strings\n")
          for b in col:gmatch(".") do
            insert(res, b)
          end
          return res
        end
      elseif (_155_ == "nil") then
        return nil
      else
        local _ = _155_
        return error(("expected table, string or nil, got " .. type(col)), 2)
      end
    else
      return error("wrong argument amount for seq", 2)
    end
  end
  core.seq = seq0
  local value_37_auto = core.seq
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Create sequential table.\n\nTransforms original table to sequential table of key value pairs\nstored as sequential tables in linear time.  If `col' is an\nassociative table, returns sequential table of vectors with key and\nvalue.  If `col' is sequential table, returns its shallow copy.  If\n`col' is string, return sequential table of its codepoints.\n\n# Examples\nSequential tables remain as is:\n\n``` fennel\n(seq [1 2 3 4])\n;; [1 2 3 4]\n```\n\nAssociative tables are transformed to format like this `[[key1 value1]\n... [keyN valueN]]` and order is non deterministic:\n\n``` fennel\n(seq {:a 1 :b 2 :c 3})\n;; [[:b 2] [:a 1] [:c 3]]\n```\n\nSee `into' macros for transforming this back to associative table.\nAdditionally you can use `conj' and `apply' with\n`hash-map':\n\n``` fennel\n(apply conj (hash-map) [:c 3] [[:a 1] [:b 2]])\n;; => {:a 1 :b 2 :c 3}\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  seq = value_37_auto
end
local kvseq
do
  local function kvseq0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_163_ = {...}
      local col = _let_163_[1]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      local _164_ = type(col)
      if (_164_ == "table") then
        local m = (getmetatable(col) or {})
        local tmp_108_auto = (m["cljlib/next"] or next)(col)
        if (tmp_108_auto == nil) then
          return nil
        else
          local _ = tmp_108_auto
          for k, v in pairs(col) do
            insert(res, {k, v})
          end
          return res
        end
      elseif (_164_ == "string") then
        if _G.utf8 then
          local char = _G.utf8.char
          for i, b in _G.utf8.codes(col) do
            insert(res, {i, char(b)})
          end
          return res
        else
          do end (io.stderr):write("WARNING: utf8 module unavailable, seq function will not work for non-unicode strings\n")
          for i = 1, #col do
            insert(res, {i, col:sub(i, i)})
          end
          return res
        end
      elseif (_164_ == "nil") then
        return nil
      else
        local _ = _164_
        return error(("expected table, string or nil, got " .. type(col)), 2)
      end
    else
      return error("wrong argument amount for kvseq", 2)
    end
  end
  core.kvseq = kvseq0
  local value_37_auto = core.kvseq
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Transforms any table `col' to key-value sequence."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  kvseq = value_37_auto
end
local first
do
  local function first0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_170_ = {...}
      local col = _let_170_[1]
      local tmp_108_auto = seq(col)
      if (tmp_108_auto == nil) then
        return nil
      else
        local col0 = tmp_108_auto
        return (col0)[1]
      end
    else
      return error("wrong argument amount for first", 2)
    end
  end
  core.first = first0
  local value_37_auto = core.first
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Return first element of a table. Calls `seq' on its argument."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  first = value_37_auto
end
local rest
do
  local function rest0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_174_ = {...}
      local col = _let_174_[1]
      local tmp_104_auto = seq(col)
      if (tmp_104_auto == nil) then
        return setmetatable({}, {["cljlib/type"] = "seq"})
      else
        local col0 = tmp_104_auto
        return vector(_unpack(col0, 2))
      end
    else
      return error("wrong argument amount for rest", 2)
    end
  end
  core.rest = rest0
  local value_37_auto = core.rest
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Returns table of all elements of a table but the first one. Calls\n  `seq' on its argument."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  rest = value_37_auto
end
local last
do
  local function last0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_178_ = {...}
      local col = _let_178_[1]
      local tmp_108_auto = seq(col)
      if (tmp_108_auto == nil) then
        return nil
      else
        local col0 = tmp_108_auto
        local i, v = next(col0)
        while i do
          local _i, _v = next(col0, i)
          if _i then
            v = _v
          end
          i = _i
        end
        return v
      end
    else
      return error("wrong argument amount for last", 2)
    end
  end
  core.last = last0
  local value_37_auto = core.last
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Returns the last element of a table. Calls `seq' on its argument."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  last = value_37_auto
end
local butlast
do
  local function butlast0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_183_ = {...}
      local col = _let_183_[1]
      local tmp_108_auto = seq(col)
      if (tmp_108_auto == nil) then
        return nil
      else
        local col0 = tmp_108_auto
        table.remove(col0, #col0)
        if not empty_3f(col0) then
          return col0
        end
      end
    else
      return error("wrong argument amount for butlast", 2)
    end
  end
  core.butlast = butlast0
  local value_37_auto = core.butlast
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Returns everything but the last element of a table as a new\n  table. Calls `seq' on its argument."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  butlast = value_37_auto
end
local conj
do
  local function conj0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 0) then
      local _let_188_ = {...}
      return setmetatable({}, {["cljlib/type"] = "seq"})
    elseif (len_77_auto == 1) then
      local _let_189_ = {...}
      local tbl = _let_189_[1]
      return tbl
    elseif (len_77_auto == 2) then
      local _let_190_ = {...}
      local tbl = _let_190_[1]
      local x = _let_190_[2]
      do
        local tmp_108_auto = x
        if (tmp_108_auto == nil) then
        else
          local x0 = tmp_108_auto
          local tbl0 = (tbl or setmetatable({}, {["cljlib/type"] = "seq"}))
          if map_3f(tbl0) then
            tbl0[(x0)[1]] = (x0)[2]
          else
            tbl0[(1 + #tbl0)] = x0
          end
        end
      end
      return tbl
    elseif (len_77_auto >= 2) then
      local _let_193_ = {...}
      local tbl = _let_193_[1]
      local x = _let_193_[2]
      local xs = {(table.unpack or unpack)(_let_193_, 3)}
      return apply(conj0, conj0(tbl, x), xs)
    end
  end
  core.conj = conj0
  local value_37_auto = core.conj
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([tbl])", "([tbl x])", "([tbl x & xs])"}, ["fnl/docstring"] = "Insert `x' as a last element of a table `tbl'.\n\nIf `tbl' is a sequential table or empty table, inserts `x' and\noptional `xs' as final element in the table.\n\nIf `tbl' is an associative table, that satisfies `map?' test,\ninsert `[key value]` pair into the table.\n\nMutates `tbl'.\n\n# Examples\nAdding to sequential tables:\n\n``` fennel\n(conj [] 1 2 3 4)\n;; => [1 2 3 4]\n(conj [1 2 3] 4 5)\n;; => [1 2 3 4 5]\n```\n\nAdding to associative tables:\n\n``` fennel\n(conj {:a 1} [:b 2] [:c 3])\n;; => {:a 1 :b 2 :c 3}\n```\n\nNote, that passing literal empty associative table `{}` will not work:\n\n``` fennel\n(conj {} [:a 1] [:b 2])\n;; => [[:a 1] [:b 2]]\n(conj (hash-map) [:a 1] [:b 2])\n;; => {:a 1 :b 2}\n```\n\nSee `hash-map' for creating empty associative tables."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  conj = value_37_auto
end
local disj
do
  local function disj0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 1) then
      local _let_196_ = {...}
      local s = _let_196_[1]
      if set_3f(s) then
        return s
      else
        return error("expected either hash-set or ordered-set as first argument", 2)
      end
    elseif (len_77_auto == 2) then
      local _let_198_ = {...}
      local s = _let_198_[1]
      local k = _let_198_[2]
      if set_3f(s) then
        local _199_ = s
        _199_[k] = nil
        return _199_
      else
        return error("expected either hash-set or ordered-set as first argument", 2)
      end
    elseif (len_77_auto >= 2) then
      local _let_201_ = {...}
      local s = _let_201_[1]
      local k = _let_201_[2]
      local ks = {(table.unpack or unpack)(_let_201_, 3)}
      return apply(disj0, disj0(s, k), ks)
    else
      return error("wrong argument amount for disj", 2)
    end
  end
  core.disj = disj0
  local value_37_auto = core.disj
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([s])", "([s k])", "([s k & ks])"}, ["fnl/docstring"] = "Remove key `k' from set `s'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  disj = value_37_auto
end
local function consj(...)
  local _let_204_ = {...}
  local tbl = _let_204_[1]
  local x = _let_204_[2]
  local xs = {(table.unpack or unpack)(_let_204_, 3)}
  if nil_3f(x) then
    return tbl
  else
    local _206_
    do
      local _205_ = tbl
      insert(_205_, 1, x)
      _206_ = _205_
    end
    return consj(_206_, _unpack(xs))
  end
end
local cons
do
  local function cons0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_208_ = {...}
      local x = _let_208_[1]
      local tbl = _let_208_[2]
      local tmp_104_auto = x
      if (tmp_104_auto == nil) then
        return tbl
      else
        local x0 = tmp_104_auto
        local _209_ = (seq(tbl) or setmetatable({}, {["cljlib/type"] = "seq"}))
        insert(_209_, 1, x0)
        return _209_
      end
    else
      return error("wrong argument amount for cons", 2)
    end
  end
  core.cons = cons0
  local value_37_auto = core.cons
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x", "tbl]"}, ["fnl/docstring"] = "Insert `x' to `tbl' at the front.  Calls `seq' on `tbl'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  cons = value_37_auto
end
local concat
do
  local function concat0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 0) then
      local _let_213_ = {...}
      return nil
    elseif (len_77_auto == 1) then
      local _let_214_ = {...}
      local x = _let_214_[1]
      return (seq(x) or setmetatable({}, {["cljlib/type"] = "seq"}))
    elseif (len_77_auto == 2) then
      local _let_215_ = {...}
      local x = _let_215_[1]
      local y = _let_215_[2]
      local to = (seq(x) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local from = (seq(y) or setmetatable({}, {["cljlib/type"] = "seq"}))
      for _, v in ipairs(from) do
        insert(to, v)
      end
      return to
    elseif (len_77_auto >= 2) then
      local _let_216_ = {...}
      local x = _let_216_[1]
      local y = _let_216_[2]
      local xs = {(table.unpack or unpack)(_let_216_, 3)}
      return apply(concat0, concat0(x, y), xs)
    end
  end
  core.concat = concat0
  local value_37_auto = core.concat
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([x])", "([x y])", "([x y & xs])"}, ["fnl/docstring"] = "Concatenate tables."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  concat = value_37_auto
end
local reduce
do
  local function reduce0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 2) then
      local _let_219_ = {...}
      local f = _let_219_[1]
      local col = _let_219_[2]
      local col0 = (seq(col) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local _220_ = #col0
      if (_220_ == 0) then
        return f()
      elseif (_220_ == 1) then
        return (col0)[1]
      elseif (_220_ == 2) then
        return f((col0)[1], (col0)[2])
      else
        local _ = _220_
        local _let_221_ = col0
        local a = _let_221_[1]
        local b = _let_221_[2]
        local rest0 = {(table.unpack or unpack)(_let_221_, 3)}
        return reduce0(f, f(a, b), rest0)
      end
    elseif (len_77_auto == 3) then
      local _let_223_ = {...}
      local f = _let_223_[1]
      local val = _let_223_[2]
      local col = _let_223_[3]
      local m = getmetatable(val)
      if (m and m["cljlib/reduced"] and (m["cljlib/reduced"].status == "ready")) then
        return m["cljlib/reduced"].val
      else
        local col0 = (seq(col) or setmetatable({}, {["cljlib/type"] = "seq"}))
        local _let_224_ = col0
        local x = _let_224_[1]
        local xs = {(table.unpack or unpack)(_let_224_, 2)}
        if nil_3f(x) then
          return val
        else
          return reduce0(f, f(val, x), xs)
        end
      end
    else
      return error("wrong argument amount for reduce", 2)
    end
  end
  core.reduce = reduce0
  local value_37_auto = core.reduce
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([f col])", "([f val col])"}, ["fnl/docstring"] = "Reduce collection `col' using function `f' and optional initial value `val'.\n\n`f' should be a function of 2 arguments.  If val is not supplied,\nreturns the result of applying f to the first 2 items in coll, then\napplying f to that result and the 3rd item, etc.  If coll contains no\nitems, f must accept no arguments as well, and reduce returns the\nresult of calling f with no arguments.  If coll has only 1 item, it is\nreturned and f is not called.  If val is supplied, returns the result\nof applying f to val and the first item in coll, then applying f to\nthat result and the 2nd item, etc.  If coll contains no items, returns\nval and f is not called.  Calls `seq' on `col'.\n\nEarly termination is possible with the use of `reduced'\nfunction.\n\n# Examples\nReduce sequence of numbers with `add'\n\n``` fennel\n(reduce add [1 2 3 4])\n;; => 10\n(reduce add 10 [1 2 3 4])\n;; => 20\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  reduce = value_37_auto
end
local reduced
do
  local function reduced0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_229_ = {...}
      local x = _let_229_[1]
      return setmetatable({}, {["cljlib/reduced"] = {status = "ready", val = x}})
    else
      return error("wrong argument amount for reduced", 2)
    end
  end
  core.reduced = reduced0
  local value_37_auto = core.reduced
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Wraps `x' in such a way so `reduce' will terminate early\nwith this value.\n\n# Examples\nStop reduction is result is higher than `10`:\n\n``` fennel\n(reduce (fn [res x]\n          (if (>= res 10)\n              (reduced res)\n              (+ res x)))\n        [1 2 3])\n;; => 6\n\n(reduce (fn [res x]\n          (if (>= res 10)\n              (reduced res)\n              (+ res x)))\n        [1 2 3 4 :nil])\n;; => 10\n```\n\nNote that in second example we had `:nil` in the array, which is not a\nvalid number, but we've terminated right before we've reached it."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  reduced = value_37_auto
end
local reduce_kv
do
  local function reduce_kv0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 3) then
      local _let_232_ = {...}
      local f = _let_232_[1]
      local val = _let_232_[2]
      local tbl = _let_232_[3]
      local res = val
      for _, _233_ in ipairs((kvseq(tbl) or setmetatable({}, {["cljlib/type"] = "seq"}))) do
        local _each_234_ = _233_
        local k = _each_234_[1]
        local v = _each_234_[2]
        res = f(res, k, v)
        local _235_ = getmetatable(res)
        if (nil ~= _235_) then
          local m = _235_
          if (m["cljlib/reduced"] and (m["cljlib/reduced"].status == "ready")) then
            res = m["cljlib/reduced"].val
            break
          end
        end
      end
      return res
    else
      return error("wrong argument amount for reduce-kv", 2)
    end
  end
  core["reduce-kv"] = reduce_kv0
  local value_37_auto = core["reduce-kv"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[f", "val", "tbl]"}, ["fnl/docstring"] = "Reduces an associative table using function `f' and initial value `val'.\n\n`f' should be a function of 3 arguments.  Returns the result of\napplying `f' to `val', the first key and the first value in `tbl',\nthen applying `f' to that result and the 2nd key and value, etc.  If\n`tbl' contains no entries, returns `val' and `f' is not called.  Note\nthat reduce-kv is supported on sequential tables and strings, where\nthe keys will be the ordinals.\n\nEarly termination is possible with the use of `reduced'\nfunction.\n\n# Examples\nReduce associative table by adding values from all keys:\n\n``` fennel\n(local t {:a1 1\n          :b1 2\n          :a2 2\n          :b2 3})\n\n(reduce-kv #(+ $1 $3) 0 t)\n;; => 8\n```\n\nReduce table by adding values from keys that start with letter `a':\n\n``` fennel\n(local t {:a1 1\n          :b1 2\n          :a2 2\n          :b2 3})\n\n(reduce-kv (fn [res k v] (if (= (string.sub k 1 1) :a) (+ res v) res))\n           0 t)\n;; => 3\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  reduce_kv = value_37_auto
end
local mapv
do
  local function mapv0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 2) then
      local _let_240_ = {...}
      local f = _let_240_[1]
      local col = _let_240_[2]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      for _, v in ipairs((seq(col) or setmetatable({}, {["cljlib/type"] = "seq"}))) do
        local tmp_108_auto = f(v)
        if (tmp_108_auto == nil) then
        else
          local tmp = tmp_108_auto
          insert(res, tmp)
        end
      end
      return res
    elseif (len_77_auto == 3) then
      local _let_242_ = {...}
      local f = _let_242_[1]
      local col1 = _let_242_[2]
      local col2 = _let_242_[3]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      local col10 = (seq(col1) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local col20 = (seq(col2) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local i1, v1 = next(col10)
      local i2, v2 = next(col20)
      while (i1 and i2) do
        do
          local tmp_108_auto = f(v1, v2)
          if (tmp_108_auto == nil) then
          else
            local tmp = tmp_108_auto
            insert(res, tmp)
          end
        end
        i1, v1 = next(col10, i1)
        i2, v2 = next(col20, i2)
      end
      return res
    elseif (len_77_auto == 4) then
      local _let_244_ = {...}
      local f = _let_244_[1]
      local col1 = _let_244_[2]
      local col2 = _let_244_[3]
      local col3 = _let_244_[4]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      local col10 = (seq(col1) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local col20 = (seq(col2) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local col30 = (seq(col3) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local i1, v1 = next(col10)
      local i2, v2 = next(col20)
      local i3, v3 = next(col30)
      while (i1 and i2 and i3) do
        do
          local tmp_108_auto = f(v1, v2, v3)
          if (tmp_108_auto == nil) then
          else
            local tmp = tmp_108_auto
            insert(res, tmp)
          end
        end
        i1, v1 = next(col10, i1)
        i2, v2 = next(col20, i2)
        i3, v3 = next(col30, i3)
      end
      return res
    elseif (len_77_auto >= 4) then
      local _let_246_ = {...}
      local f = _let_246_[1]
      local col1 = _let_246_[2]
      local col2 = _let_246_[3]
      local col3 = _let_246_[4]
      local cols = {(table.unpack or unpack)(_let_246_, 5)}
      local step
      local function step0(cols0)
        local function _247_(_241, _242)
          return (_241 and _242)
        end
        local function _248_(_241)
          return (next(_241) ~= nil)
        end
        if reduce(_247_, mapv0(_248_, cols0)) then
          local function _249_(_241)
            return ((seq(_241) or setmetatable({}, {["cljlib/type"] = "seq"})))[1]
          end
          local function _250_(_241)
            return {_unpack(_241, 2)}
          end
          return cons(mapv0(_249_, cols0), step0(mapv0(_250_, cols0)))
        else
          return setmetatable({}, {["cljlib/type"] = "seq"})
        end
      end
      step = step0
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      for _, v in ipairs(step(consj(cols, col3, col2, col1))) do
        local tmp_108_auto = apply(f, v)
        if (tmp_108_auto == nil) then
        else
          local tmp = tmp_108_auto
          insert(res, tmp)
        end
      end
      return res
    else
      return error("wrong argument amount for mapv", 2)
    end
  end
  core.mapv = mapv0
  local value_37_auto = core.mapv
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"\n  ([f col])", "\n  ([f col1 col2])", "\n  ([f col1 col2 col3])", "\n  ([f col1 col2 col3 & cols])"}, ["fnl/docstring"] = "Maps function `f' over one or more collections.\n\nAccepts arbitrary amount of collections, calls `seq' on each of it.\nFunction `f' must take the same amount of arguments as the amount of\ntables, passed to `mapv'. Applies `f' over first value of each\ntable. Then applies `f' to second value of each table. Continues until\nany of the tables is exhausted. All remaining values are\nignored. Returns a sequential table of results.\n\n# Examples\nMap `string.upcase' over the string:\n\n``` fennel\n(mapv string.upper \"string\")\n;; => [\"S\" \"T\" \"R\" \"I\" \"N\" \"G\"]\n```\n\nMap `mul' over two tables:\n\n``` fennel\n(mapv mul [1 2 3 4] [1 0 -1])\n;; => [1 0 -3]\n```\n\nBasic `zipmap' implementation:\n\n``` fennel\n(import-macros {: into} :bubbly.lib.cljlib.macros)\n(fn zipmap [keys vals]\n  (into {} (mapv vector keys vals)))\n\n(zipmap [:a :b :c] [1 2 3 4])\n;; => {:a 1 :b 2 :c 3}\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  mapv = value_37_auto
end
local filter
do
  local function filter0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_255_ = {...}
      local pred = _let_255_[1]
      local col = _let_255_[2]
      local tmp_94_auto = seq(col)
      if tmp_94_auto then
        local col0 = tmp_94_auto
        local f = (col0)[1]
        local r = {_unpack(col0, 2)}
        if pred(f) then
          return cons(f, filter0(pred, r))
        else
          return filter0(pred, r)
        end
      else
        return setmetatable({}, {["cljlib/type"] = "seq"})
      end
    else
      return error("wrong argument amount for filter", 2)
    end
  end
  core.filter = filter0
  local value_37_auto = core.filter
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[pred", "col]"}, ["fnl/docstring"] = "Returns a sequential table of the items in `col' for which `pred'\n  returns logical true."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  filter = value_37_auto
end
local every_3f
do
  local function every_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_260_ = {...}
      local pred = _let_260_[1]
      local tbl = _let_260_[2]
      if empty_3f(tbl) then
        return true
      elseif pred(tbl[1]) then
        return every_3f0(pred, {_unpack(tbl, 2)})
      else
        return false
      end
    else
      return error("wrong argument amount for every?", 2)
    end
  end
  core["every?"] = every_3f0
  local value_37_auto = core["every?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[pred", "tbl]"}, ["fnl/docstring"] = "Test if every item in `tbl' satisfies the `pred'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  every_3f = value_37_auto
end
local some
do
  local function some0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_264_ = {...}
      local pred = _let_264_[1]
      local tbl = _let_264_[2]
      local tmp_98_auto = seq(tbl)
      if tmp_98_auto then
        local tbl0 = tmp_98_auto
        return (pred((tbl0)[1]) or some0(pred, {_unpack(tbl0, 2)}))
      end
    else
      return error("wrong argument amount for some", 2)
    end
  end
  core.some = some0
  local value_37_auto = core.some
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[pred", "tbl]"}, ["fnl/docstring"] = "Test if any item in `tbl' satisfies the `pred'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  some = value_37_auto
end
local not_any_3f
do
  local function not_any_3f0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_268_ = {...}
      local pred = _let_268_[1]
      local tbl = _let_268_[2]
      local function _269_(_241)
        return not pred(_241)
      end
      return some(_269_, tbl)
    else
      return error("wrong argument amount for not-any?", 2)
    end
  end
  core["not-any?"] = not_any_3f0
  local value_37_auto = core["not-any?"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[pred", "tbl]"}, ["fnl/docstring"] = "Test if no item in `tbl' satisfy the `pred'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  not_any_3f = value_37_auto
end
local range
do
  local function range0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 1) then
      local _let_272_ = {...}
      local upper = _let_272_[1]
      return range0(0, upper, 1)
    elseif (len_77_auto == 2) then
      local _let_273_ = {...}
      local lower = _let_273_[1]
      local upper = _let_273_[2]
      return range0(lower, upper, 1)
    elseif (len_77_auto == 3) then
      local _let_274_ = {...}
      local lower = _let_274_[1]
      local upper = _let_274_[2]
      local step = _let_274_[3]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      for i = lower, (upper - step), step do
        insert(res, i)
      end
      return res
    else
      return error("wrong argument amount for range", 2)
    end
  end
  core.range = range0
  local value_37_auto = core.range
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([upper])", "([lower upper])", "([lower upper step])"}, ["fnl/docstring"] = "return range of of numbers from `lower' to `upper' with optional `step'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  range = value_37_auto
end
local reverse
do
  local function reverse0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_277_ = {...}
      local tbl = _let_277_[1]
      local tmp_108_auto = seq(tbl)
      if (tmp_108_auto == nil) then
        return nil
      else
        local tbl0 = tmp_108_auto
        return reduce(consj, setmetatable({}, {["cljlib/type"] = "seq"}), tbl0)
      end
    else
      return error("wrong argument amount for reverse", 2)
    end
  end
  core.reverse = reverse0
  local value_37_auto = core.reverse
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Returns table with same items as in `tbl' but in reverse order."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  reverse = value_37_auto
end
local take
do
  local function take0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_281_ = {...}
      local n = _let_281_[1]
      local col = _let_281_[2]
      if (n == 0) then
        return {}
      elseif pos_int_3f(n) then
        local tmp_94_auto = seq(col)
        if tmp_94_auto then
          local s = tmp_94_auto
          return cons(first(s), take0(dec(n), rest(s)))
        else
          return nil
        end
      else
        return error("expected positive integer as first argument", 2)
      end
    else
      return error("wrong argument amount for take", 2)
    end
  end
  core.take = take0
  local value_37_auto = core.take
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[n", "col]"}, ["fnl/docstring"] = "Returns a sequence of the first `n' items in `col', or all items if\nthere are fewer than `n'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  take = value_37_auto
end
local nthrest
do
  local function nthrest0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_286_ = {...}
      local col = _let_286_[1]
      local n = _let_286_[2]
      return {_unpack(col, inc(n))}
    else
      return error("wrong argument amount for nthrest", 2)
    end
  end
  core.nthrest = nthrest0
  local value_37_auto = core.nthrest
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[col", "n]"}, ["fnl/docstring"] = "Returns the nth rest of `col', `col' when `n' is 0.\n\n# Examples\n\n``` fennel\n(assert-eq (nthrest [1 2 3 4] 3) [4])\n(assert-eq (nthrest [1 2 3 4] 2) [3 4])\n(assert-eq (nthrest [1 2 3 4] 1) [2 3 4])\n(assert-eq (nthrest [1 2 3 4] 0) [1 2 3 4])\n```\n"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  nthrest = value_37_auto
end
local partition
do
  local function partition0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 2) then
      local _let_289_ = {...}
      local n = _let_289_[1]
      local col = _let_289_[2]
      return partition0(n, n, col)
    elseif (len_77_auto == 3) then
      local _let_290_ = {...}
      local n = _let_290_[1]
      local step = _let_290_[2]
      local col = _let_290_[3]
      local tmp_94_auto = seq(col)
      if tmp_94_auto then
        local s = tmp_94_auto
        local p = take(n, s)
        if (n == #p) then
          return cons(p, partition0(n, step, nthrest(s, step)))
        else
          return nil
        end
      else
        return nil
      end
    elseif (len_77_auto == 4) then
      local _let_293_ = {...}
      local n = _let_293_[1]
      local step = _let_293_[2]
      local pad = _let_293_[3]
      local col = _let_293_[4]
      local tmp_94_auto = seq(col)
      if tmp_94_auto then
        local s = tmp_94_auto
        local p = take(n, s)
        if (n == #p) then
          return cons(p, partition0(n, step, pad, nthrest(s, step)))
        else
          return {take(n, concat(p, pad))}
        end
      else
        return nil
      end
    else
      return error("wrong argument amount for partition", 2)
    end
  end
  core.partition = partition0
  local value_37_auto = core.partition
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([n col])", "([n step col])", "([n step pad col])"}, ["fnl/docstring"] = "Returns a sequence of sequences of `n' items each, at offsets step\napart. If `step' is not supplied, defaults to `n', i.e. the partitions\ndo not overlap. If a `pad' collection is supplied, use its elements as\nnecessary to complete last partition up to `n' items. In case there\nare not enough padding elements, return a partition with less than `n'\nitems.\n\n# Examples\nPartition sequence into sub-sequences of size 3:\n\n``` fennel\n(assert-eq (partition 3 [1 2 3 4 5 6]) [[1 2 3] [4 5 6]])\n```\n\nWhen collection doesn't have enough elements, partition will not include those:\n\n``` fennel\n(assert-eq (partition 3 [1 2 3 4]) [[1 2 3]])\n```\n\nPartitions can overlap if step is supplied:\n\n``` fennel\n(assert-eq (partition 2 1 [1 2 3 4]) [[1 2] [2 3] [3 4]])\n```\n\nAdditional padding can be used to supply insufficient elements:\n\n``` fennel\n(assert-eq (partition 3 3 [3 2 1] [1 2 3 4]) [[1 2 3] [4 3 2]])\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  partition = value_37_auto
end
local sequence_doc_order = {"vector", "seq", "kvseq", "first", "rest", "last", "butlast", "conj", "disj", "cons", "concat", "reduce", "reduced", "reduce-kv", "mapv", "filter", "every?", "some", "not-any?", "range", "reverse", "take", "nthrest", "partition"}
local eq = nil
local function deep_index(tbl, key)
  local res = nil
  for k, v in pairs(tbl) do
    if eq(k, key) then
      res = v
      break
    end
  end
  return res
end
local _eq
do
  local value_37_auto
  local function _eq0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 1) then
      local _let_299_ = {...}
      local x = _let_299_[1]
      return true
    elseif (len_77_auto == 2) then
      local _let_300_ = {...}
      local x = _let_300_[1]
      local y = _let_300_[2]
      if (x == y) then
        return true
      elseif ((type(x) == "table") and (type(y) == "table")) then
        local _var_301_ = {true, 0, 0}
        local res = _var_301_[1]
        local count_a = _var_301_[2]
        local count_b = _var_301_[3]
        for k, v in pairs(x) do
          res = eq(v, deep_index(y, k))
          count_a = (count_a + 1)
          if not res then
            break
          end
        end
        if res then
          for _, _0 in pairs(y) do
            count_b = (count_b + 1)
          end
          res = (count_a == count_b)
        end
        return res
      elseif "else" then
        return false
      end
    elseif (len_77_auto >= 2) then
      local _let_305_ = {...}
      local x = _let_305_[1]
      local y = _let_305_[2]
      local xs = {(table.unpack or unpack)(_let_305_, 3)}
      return (eq(x, y) and apply(eq, x, xs))
    else
      return error("wrong argument amount for _eq", 2)
    end
  end
  value_37_auto = _eq0
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([x])", "([x y])", "([x y & xs])"}, ["fnl/docstring"] = "Deep compare values.\n\n# Examples\n\n`eq' can compare both primitive types, tables, and user defined types\nthat have `__eq` metamethod.\n\n``` fennel\n(assert-is (eq 42 42))\n(assert-is (eq [1 2 3] [1 2 3]))\n(assert-is (eq (hash-set :a :b :c) (hash-set :a :b :c)))\n(assert-is (eq (hash-set :a :b :c) (ordered-set :c :b :a)))\n```\n\nDeep comparison is used for tables which use tables as keys:\n\n``` fennel\n(assert-is (eq {[1 2 3] {:a [1 2 3]} {:a 1} {:b 2}}\n               {{:a 1} {:b 2} [1 2 3] {:a [1 2 3]}}))\n(assert-is (eq {{{:a 1} {:b 1}} {{:c 3} {:d 4}} [[1] [2 [3]]] {:a 2}}\n               {[[1] [2 [3]]] {:a 2} {{:a 1} {:b 1}} {{:c 3} {:d 4}}}))\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  _eq = value_37_auto
end
eq = _eq
core.eq = _eq
local identity
do
  local function identity0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_308_ = {...}
      local x = _let_308_[1]
      return x
    else
      return error("wrong argument amount for identity", 2)
    end
  end
  core.identity = identity0
  local value_37_auto = core.identity
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Returns its argument."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  identity = value_37_auto
end
local comp
do
  local function comp0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 0) then
      local _let_311_ = {...}
      return identity
    elseif (len_77_auto == 1) then
      local _let_312_ = {...}
      local f = _let_312_[1]
      return f
    elseif (len_77_auto == 2) then
      local _let_313_ = {...}
      local f = _let_313_[1]
      local g = _let_313_[2]
      local value_37_auto
      local function _314_(...)
        local len_77_auto0 = select("#", ...)
        if (len_77_auto0 == 0) then
          local _let_315_ = {...}
          return f(g())
        elseif (len_77_auto0 == 1) then
          local _let_316_ = {...}
          local x = _let_316_[1]
          return f(g(x))
        elseif (len_77_auto0 == 2) then
          local _let_317_ = {...}
          local x = _let_317_[1]
          local y = _let_317_[2]
          return f(g(x, y))
        elseif (len_77_auto0 == 3) then
          local _let_318_ = {...}
          local x = _let_318_[1]
          local y = _let_318_[2]
          local z = _let_318_[3]
          return f(g(x, y, z))
        elseif (len_77_auto0 >= 3) then
          local _let_319_ = {...}
          local x = _let_319_[1]
          local y = _let_319_[2]
          local z = _let_319_[3]
          local args = {(table.unpack or unpack)(_let_319_, 4)}
          return f(g(x, y, z, _unpack(args)))
        end
      end
      value_37_auto = _314_
      local res_38_auto, fennel_39_auto = pcall(require, "fennel")
      if res_38_auto then
        for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([x])", "([x y])", "([x y z])", "([x y z & args])"}}) do
          do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
        end
      end
      return value_37_auto
    elseif (len_77_auto >= 2) then
      local _let_322_ = {...}
      local f = _let_322_[1]
      local g = _let_322_[2]
      local fs = {(table.unpack or unpack)(_let_322_, 3)}
      return reduce(comp0, consj(fs, g, f))
    end
  end
  core.comp = comp0
  local value_37_auto = core.comp
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([f])", "([f g])", "([f g & fs])"}, ["fnl/docstring"] = "Compose functions."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  comp = value_37_auto
end
local complement
do
  local function complement0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_325_ = {...}
      local f = _let_325_[1]
      local value_37_auto
      local function _326_(...)
        local len_77_auto = select("#", ...)
        if (len_77_auto == 0) then
          local _let_327_ = {...}
          return not f()
        elseif (len_77_auto == 1) then
          local _let_328_ = {...}
          local a = _let_328_[1]
          return not f(a)
        elseif (len_77_auto == 2) then
          local _let_329_ = {...}
          local a = _let_329_[1]
          local b = _let_329_[2]
          return not f(a, b)
        elseif (len_77_auto >= 2) then
          local _let_330_ = {...}
          local a = _let_330_[1]
          local b = _let_330_[2]
          local cs = {(table.unpack or unpack)(_let_330_, 3)}
          return not apply(f, a, b, cs)
        end
      end
      value_37_auto = _326_
      local res_38_auto, fennel_39_auto = pcall(require, "fennel")
      if res_38_auto then
        for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([a])", "([a b])", "([a b & cs])"}}) do
          do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
        end
      end
      return value_37_auto
    else
      return error("wrong argument amount for complement", 2)
    end
  end
  core.complement = complement0
  local value_37_auto = core.complement
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[f]"}, ["fnl/docstring"] = "Takes a function `f' and returns the function that takes the same\namount of arguments as `f', has the same effect, and returns the\noppisite truth value."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  complement = value_37_auto
end
local constantly
do
  local function constantly0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_335_ = {...}
      local x = _let_335_[1]
      local function _336_()
        return x
      end
      return _336_
    else
      return error("wrong argument amount for constantly", 2)
    end
  end
  core.constantly = constantly0
  local value_37_auto = core.constantly
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Returns a function that takes any number of arguments and returns `x'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  constantly = value_37_auto
end
local memoize
do
  local function memoize0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_339_ = {...}
      local f = _let_339_[1]
      local memo = setmetatable({}, {__index = deep_index})
      local function _340_(...)
        local args = {...}
        local tmp_104_auto = memo[args]
        if (tmp_104_auto == nil) then
          local res = f(...)
          do end (memo)[args] = res
          return res
        else
          local res = tmp_104_auto
          return res
        end
      end
      return _340_
    else
      return error("wrong argument amount for memoize", 2)
    end
  end
  core.memoize = memoize0
  local value_37_auto = core.memoize
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[f]"}, ["fnl/docstring"] = "Returns a memoized version of a referentially transparent function.\nThe memoized version of the function keeps a cache of the mapping from\narguments to results and, when calls with the same arguments are\nrepeated often, has higher performance at the expense of higher memory\nuse."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  memoize = value_37_auto
end
local function_manipulation_doc_order = {"identity", "comp", "complement", "constantly", "memoize"}
local assoc
do
  local function assoc0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 3) then
      local _let_344_ = {...}
      local tbl = _let_344_[1]
      local k = _let_344_[2]
      local v = _let_344_[3]
      assert(not nil_3f(k), "attempt to use nil as key")
      local _346_
      do
        local _345_ = tbl
        _345_[k] = v
        _346_ = _345_
      end
      return setmetatable(_346_, {["cljlib/type"] = "table"})
    elseif (len_77_auto >= 3) then
      local _let_347_ = {...}
      local tbl = _let_347_[1]
      local k = _let_347_[2]
      local v = _let_347_[3]
      local kvs = {(table.unpack or unpack)(_let_347_, 4)}
      assert(((#kvs % 2) == 0), ("no value supplied for key " .. kvs[#kvs]))
      assert(not nil_3f(k), "attempt to use nil as key")
      do end (tbl)[k] = v
      local _var_348_ = {nil, nil}
      local k0 = _var_348_[1]
      local v0 = _var_348_[2]
      local i, k1 = next(kvs)
      while i do
        i, v0 = next(kvs, i)
        do end (tbl)[k1] = v0
        i, k1 = next(kvs, i)
      end
      return setmetatable(tbl, {["cljlib/type"] = "table"})
    else
      return error("wrong argument amount for assoc", 2)
    end
  end
  core.assoc = assoc0
  local value_37_auto = core.assoc
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([tbl k v])", "([tbl k v & kvs])"}, ["fnl/docstring"] = "Associate key `k' with value `v' in `tbl'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  assoc = value_37_auto
end
local hash_map
do
  local function hash_map0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 0) then
      local _let_351_ = {...}
      return setmetatable({}, {["cljlib/type"] = "table"})
    elseif (len_77_auto >= 0) then
      local _let_352_ = {...}
      local kvs = {(table.unpack or unpack)(_let_352_, 1)}
      return apply(assoc, {}, kvs)
    end
  end
  core["hash-map"] = hash_map0
  local value_37_auto = core["hash-map"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([])", "([& kvs])"}, ["fnl/docstring"] = "Create associative table from `kvs' represented as sequence of keys\nand values"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  hash_map = value_37_auto
end
local get
do
  local function get0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 2) then
      local _let_355_ = {...}
      local tbl = _let_355_[1]
      local key = _let_355_[2]
      return get0(tbl, key, nil)
    elseif (len_77_auto == 3) then
      local _let_356_ = {...}
      local tbl = _let_356_[1]
      local key = _let_356_[2]
      local not_found = _let_356_[3]
      local tmp_104_auto = tbl[key]
      if (tmp_104_auto == nil) then
        return not_found
      else
        local res = tmp_104_auto
        return res
      end
    else
      return error("wrong argument amount for get", 2)
    end
  end
  core.get = get0
  local value_37_auto = core.get
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([tbl key])", "([tbl key not-found])"}, ["fnl/docstring"] = "Get value from the table by accessing it with a `key'.\nAccepts additional `not-found' as a marker to return if value wasn't\nfound in the table."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  get = value_37_auto
end
local get_in
do
  local function get_in0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 2) then
      local _let_360_ = {...}
      local tbl = _let_360_[1]
      local keys = _let_360_[2]
      return get_in0(tbl, keys, nil)
    elseif (len_77_auto == 3) then
      local _let_361_ = {...}
      local tbl = _let_361_[1]
      local keys = _let_361_[2]
      local not_found = _let_361_[3]
      local res = tbl
      local t = tbl
      for _, k in ipairs(keys) do
        local tmp_104_auto = t[k]
        if (tmp_104_auto == nil) then
          res = not_found
        else
          local v = tmp_104_auto
          local _set_362_ = {v, v}
          res = _set_362_[1]
          t = _set_362_[2]
        end
      end
      return res
    else
      return error("wrong argument amount for get-in", 2)
    end
  end
  core["get-in"] = get_in0
  local value_37_auto = core["get-in"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([tbl keys])", "([tbl keys not-found])"}, ["fnl/docstring"] = "Get value from nested set of tables by providing key sequence.\nAccepts additional `not-found' as a marker to return if value wasn't\nfound in the table."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  get_in = value_37_auto
end
local keys
do
  local function keys0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_366_ = {...}
      local tbl = _let_366_[1]
      local res = {}
      for k, _ in pairs(tbl) do
        insert(res, k)
      end
      return res
    else
      return error("wrong argument amount for keys", 2)
    end
  end
  core.keys = keys0
  local value_37_auto = core.keys
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Returns a sequence of the table's keys, in the same order as `seq'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  keys = value_37_auto
end
local vals
do
  local function vals0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_369_ = {...}
      local tbl = _let_369_[1]
      local res = {}
      for _, v in pairs(tbl) do
        insert(res, v)
      end
      return res
    else
      return error("wrong argument amount for vals", 2)
    end
  end
  core.vals = vals0
  local value_37_auto = core.vals
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Returns a sequence of the table's values, in the same order as `seq'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  vals = value_37_auto
end
local find
do
  local function find0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_372_ = {...}
      local tbl = _let_372_[1]
      local key = _let_372_[2]
      local tmp_108_auto = tbl[key]
      if (tmp_108_auto == nil) then
        return nil
      else
        local v = tmp_108_auto
        return {key, v}
      end
    else
      return error("wrong argument amount for find", 2)
    end
  end
  core.find = find0
  local value_37_auto = core.find
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[tbl", "key]"}, ["fnl/docstring"] = "Returns the map entry for `key', or `nil' if key not present in `tbl'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  find = value_37_auto
end
local dissoc
do
  local function dissoc0(...)
    local len_77_auto = select("#", ...)
    if (len_77_auto == 1) then
      local _let_376_ = {...}
      local tbl = _let_376_[1]
      return tbl
    elseif (len_77_auto == 2) then
      local _let_377_ = {...}
      local tbl = _let_377_[1]
      local key = _let_377_[2]
      local _378_ = tbl
      _378_[key] = nil
      return _378_
    elseif (len_77_auto >= 2) then
      local _let_379_ = {...}
      local tbl = _let_379_[1]
      local key = _let_379_[2]
      local keys0 = {(table.unpack or unpack)(_let_379_, 3)}
      return apply(dissoc0, dissoc0(tbl, key), keys0)
    else
      return error("wrong argument amount for dissoc", 2)
    end
  end
  core.dissoc = dissoc0
  local value_37_auto = core.dissoc
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"([tbl])", "([tbl key])", "([tbl key & keys])"}, ["fnl/docstring"] = "Remove `key' from table `tbl'.  Optionally takes more `keys`."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  dissoc = value_37_auto
end
local hash_table_doc_order = {"assoc", "hash-map", "get", "get-in", "keys", "vals", "find", "dissoc"}
local remove_method
do
  local function remove_method0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_382_ = {...}
      local multimethod = _let_382_[1]
      local dispatch_value = _let_382_[2]
      if multifn_3f(multimethod) then
        multimethod[dispatch_value] = nil
      else
        error((tostring(multimethod) .. " is not a multifn"), 2)
      end
      return multimethod
    else
      return error("wrong argument amount for remove-method", 2)
    end
  end
  core["remove-method"] = remove_method0
  local value_37_auto = core["remove-method"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[multimethod", "dispatch-value]"}, ["fnl/docstring"] = "Remove method from `multimethod' for given `dispatch-value'."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  remove_method = value_37_auto
end
local remove_all_methods
do
  local function remove_all_methods0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_386_ = {...}
      local multimethod = _let_386_[1]
      if multifn_3f(multimethod) then
        for k, _ in pairs(multimethod) do
          multimethod[k] = nil
        end
      else
        error((tostring(multimethod) .. " is not a multifn"), 2)
      end
      return multimethod
    else
      return error("wrong argument amount for remove-all-methods", 2)
    end
  end
  core["remove-all-methods"] = remove_all_methods0
  local value_37_auto = core["remove-all-methods"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[multimethod]"}, ["fnl/docstring"] = "Removes all of the methods of `multimethod'"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  remove_all_methods = value_37_auto
end
local methods
do
  local function methods0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 1) then
      local _let_390_ = {...}
      local multimethod = _let_390_[1]
      if multifn_3f(multimethod) then
        local m = {}
        for k, v in pairs(multimethod) do
          m[k] = v
        end
        return m
      else
        return error((tostring(multimethod) .. " is not a multifn"), 2)
      end
    else
      return error("wrong argument amount for methods", 2)
    end
  end
  core.methods = methods0
  local value_37_auto = core.methods
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[multimethod]"}, ["fnl/docstring"] = "Given a `multimethod', returns a map of dispatch values -> dispatch fns"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  methods = value_37_auto
end
local get_method
do
  local function get_method0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto == 2) then
      local _let_394_ = {...}
      local multimethod = _let_394_[1]
      local dispatch_value = _let_394_[2]
      if multifn_3f(multimethod) then
        return (multimethod[dispatch_value] or multimethod.default)
      else
        return error((tostring(multimethod) .. " is not a multifn"), 2)
      end
    else
      return error("wrong argument amount for get-method", 2)
    end
  end
  core["get-method"] = get_method0
  local value_37_auto = core["get-method"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[multimethod", "dispatch-value]"}, ["fnl/docstring"] = "Given a `multimethod' and a `dispatch-value', returns the dispatch\n`fn' that would apply to that value, or `nil' if none apply and no\ndefault."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  get_method = value_37_auto
end
local multimethods_doc_order = {"remove-method", "remove-all-methods", "methods", "get-method"}
local function viewset(Set, view, inspector, indent)
  if inspector.seen[Set] then
    return ("@set" .. inspector.seen[Set] .. "{...}")
  else
    local prefix
    local _398_
    if inspector["visible-cycle?"](Set) then
      _398_ = inspector.seen[Set]
    else
      _398_ = ""
    end
    prefix = ("@set" .. _398_ .. "{")
    local set_indent = #prefix
    local indent_str = string.rep(" ", set_indent)
    local lines
    do
      local tbl_12_auto = {}
      for v in pairs(Set) do
        tbl_12_auto[(#tbl_12_auto + 1)] = (indent_str .. view(v, inspector, (indent + set_indent), true))
      end
      lines = tbl_12_auto
    end
    lines[1] = (prefix .. string.gsub((lines[1] or ""), "^%s+", ""))
    do end (lines)[#lines] = (lines[#lines] .. "}")
    return lines
  end
end
local function ordered_set_newindex(Set)
  local function _401_(t, k, v)
    if (nil == v) then
      local k0 = Set[k]
      for key, index in pairs(Set) do
        if (index == k0) then
          Set[key] = nil
        elseif (index > k0) then
          Set[key] = (index - 1)
        end
      end
      return nil
    else
      if not Set[v] then
        Set[v] = (1 + #t)
        return nil
      end
    end
  end
  return _401_
end
local function hash_set_newindex(Set)
  local function _405_(t, k, v)
    if (nil == v) then
      for key, _ in pairs(Set) do
        if eq(key, k) then
          Set[key] = nil
          break
        end
      end
      return nil
    else
      if not Set[v] then
        Set[v] = true
        return nil
      end
    end
  end
  return _405_
end
local function set_length(Set)
  local function _409_()
    local len = 0
    for _, _0 in pairs(Set) do
      len = (1 + len)
    end
    return len
  end
  return _409_
end
local function set_eq(s1, s2)
  local _var_410_ = {0, true}
  local size = _var_410_[1]
  local res = _var_410_[2]
  for i, k in pairs(s1) do
    size = (size + 1)
    if res then
      res = (s2)[k]
    else
      break
    end
  end
  return (res and (size == #s2))
end
local function set__3eiseq(Set)
  local tbl_9_auto = {}
  for v, k in pairs(Set) do
    local _412_, _413_ = k, v
    if ((nil ~= _412_) and (nil ~= _413_)) then
      local k_10_auto = _412_
      local v_11_auto = _413_
      tbl_9_auto[k_10_auto] = v_11_auto
    end
  end
  return tbl_9_auto
end
local function ordered_set_pairs(Set)
  local function _415_()
    local i = 0
    local iseq = nil
    local function set_next(t, _)
      if not iseq then
        iseq = set__3eiseq(Set)
      end
      i = (i + 1)
      local v = iseq[i]
      return v, v
    end
    return set_next, Set, nil
  end
  return _415_
end
local function hash_set_pairs(Set)
  local function _417_()
    local function iter(t, k)
      local v = next(t, k)
      return v, v
    end
    return iter, Set, nil
  end
  return _417_
end
local function into_set(Set, tbl)
  for _, v in pairs((seq(tbl) or {})) do
    conj(Set, v)
  end
  return Set
end
local ordered_set
do
  local function ordered_set0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto >= 0) then
      local _let_418_ = {...}
      local xs = {(table.unpack or unpack)(_let_418_, 1)}
      local Set = setmetatable({}, {__index = deep_index})
      local set_pairs = ordered_set_pairs(Set)
      local i = 1
      for _, val in ipairs(xs) do
        if not Set[val] then
          Set[val] = i
          i = (1 + i)
        end
      end
      local function _420_()
        return ordered_set0()
      end
      local function _421_(_241, _242)
        return next(Set, _242)
      end
      local function _422_(_241, _242)
        if Set[_242] then
          return _242
        else
          return nil
        end
      end
      local function _424_(_241, _242)
        if Set[_242] then
          return _242
        else
          return nil
        end
      end
      return setmetatable({}, {["cljlib/empty"] = _420_, ["cljlib/into"] = into_set, ["cljlib/next"] = _421_, ["cljlib/type"] = "cljlib/ordered-set", __call = _422_, __eq = set_eq, __fennelview = viewset, __index = _424_, __len = set_length(Set), __name = "ordered set", __newindex = ordered_set_newindex(Set), __pairs = set_pairs})
    end
  end
  core["ordered-set"] = ordered_set0
  local value_37_auto = core["ordered-set"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[&", "xs]"}, ["fnl/docstring"] = "Create ordered set.\n\nSet is a collection of unique elements, which sore purpose is only to\ntell you if something is in the set or not.\n\n`ordered-set' is follows the argument insertion order, unlike sorted\nsets, which apply some sorting algorithm internally. New items added\nat the end of the set. Ordered set supports removal of items via\n`tset' and `disj'. To add element to the ordered set use\n`tset' or `conj'. Both operations modify the set.\n\n**Note**: Hash set prints as `@set{a b c}`, but this construct is not\nsupported by the Fennel reader, so you can't create sets with this\nsyntax. Use `ordered-set' function instead.\n\nBelow are some examples of how to create and manipulate sets.\n\n## Create ordered set:\nOrdered sets are created by passing any amount of elements desired to\nbe in the set:\n\n``` fennel\n(ordered-set)\n;; => @set{}\n(ordered-set :a :c :b)\n;; => @set{:a :c :b}\n```\n\nDuplicate items are not added:\n\n``` fennel\n(ordered-set :a :c :a :a :a :a :c :b)\n;; => @set{:a :c :b}\n```\n\n## Check if set contains desired value:\nSets are functions of their keys, so simply calling a set with a\ndesired key will either return the key, or `nil':\n\n``` fennel\n(local oset (ordered-set [:a :b :c] [:c :d :e] :e :f))\n(oset [:a :b :c])\n;; => [\"a\" \"b\" \"c\"]\n(. oset :e)\n;; \"e\"\n(oset [:a :b :f])\n;; => nil\n```\n\n## Add items to existing set:\nTo add element to the set use `conj' or `tset'\n\n``` fennel\n(local oset (ordered-set :a :b :c))\n(conj oset :d :e)\n;; => @set{:a :b :c :d :e}\n```\n\n### Remove items from the set:\nTo add element to the set use `disj' or `tset'\n\n``` fennel\n(local oset (ordered-set :a :b :c))\n(disj oset :b)\n;; => @set{:a :c}\n(tset oset :a nil)\noset\n;; => @set{:c}\n```\n\n## Equality semantics\nBoth `ordered-set' and `hash-set' implement `__eq` metamethod,\nand are compared for having the same keys without particular order and\nsame size:\n\n``` fennel\n(assert-eq (ordered-set :a :b) (ordered-set :b :a))\n(assert-ne (ordered-set :a :b) (ordered-set :b :a :c))\n(assert-eq (ordered-set :a :b) (hash-set :a :b))\n```"}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  ordered_set = value_37_auto
end
local hash_set
do
  local function hash_set0(...)
    local len_71_auto = select("#", ...)
    if (len_71_auto >= 0) then
      local _let_428_ = {...}
      local xs = {(table.unpack or unpack)(_let_428_, 1)}
      local Set = setmetatable({}, {__index = deep_index})
      local set_pairs = hash_set_pairs(Set)
      for _, val in ipairs(xs) do
        if not Set[val] then
          Set[val] = true
        end
      end
      local function _430_()
        return hash_set0()
      end
      local function _431_(_241, _242)
        return next(Set, _242)
      end
      local function _432_(_241, _242)
        if Set[_242] then
          return _242
        else
          return nil
        end
      end
      local function _434_(_241, _242)
        if Set[_242] then
          return _242
        else
          return nil
        end
      end
      return setmetatable({}, {["cljlib/empty"] = _430_, ["cljlib/into"] = into_set, ["cljlib/next"] = _431_, ["cljlib/type"] = "cljlib/hash-set", __call = _432_, __eq = set_eq, __fennelview = viewset, __index = _434_, __len = set_length(Set), __name = "hash set", __newindex = hash_set_newindex(Set), __pairs = set_pairs})
    end
  end
  core["hash-set"] = hash_set0
  local value_37_auto = core["hash-set"]
  local res_38_auto, fennel_39_auto = pcall(require, "fennel")
  if res_38_auto then
    for k_40_auto, v_41_auto in pairs({["fnl/arglist"] = {"[&", "xs]"}, ["fnl/docstring"] = "Create hash set.\n\nSet is a collection of unique elements, which sore purpose is only to\ntell you if something is in the set or not.\n\nHash set differs from ordered set in that the keys are do not have any\nparticular order. New items are added at the arbitrary position by\nusing `conj' or `tset' functions, and items can be removed\nwith `disj' or `tset' functions. Rest semantics are the same\nas for `ordered-set'\n\n**Note**: Hash set prints as `@set{a b c}`, but this construct is not\nsupported by the Fennel reader, so you can't create sets with this\nsyntax. Use `hash-set' function instead."}) do
      do end (fennel_39_auto.metadata):set(value_37_auto, k_40_auto, v_41_auto)
    end
  end
  hash_set = value_37_auto
end
local set_doc_order = {"ordered-set", "hash-set"}
module_info._DOC_ORDER = concat(utility_doc_order, {"eq"}, predicate_doc_order, sequence_doc_order, function_manipulation_doc_order, hash_table_doc_order, multimethods_doc_order, set_doc_order)
return setmetatable(core, {__index = module_info})