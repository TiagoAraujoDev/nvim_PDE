local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require "luasnip.extras"
local rep = extras.rep
-- local c = ls.choice_node
-- local types = require "luasnip.util.types"
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local parse = require("luasnip.util.parser").parse_snippet
return {
  s("req", fmt([[local {} = require "{}"]], { i(1, "default"), rep(1) })),
  s(
    "pcall",
    fmt(
      [[
      local status_ok, {} = pcall (require, "{}")
      if not status_ok then
        return
      end]],
      { i(1, "default"), rep(1) }
    )
  ),
}
