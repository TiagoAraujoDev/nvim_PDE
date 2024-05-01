local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
-- local extras = require "luasnip.extras"
-- local rep = extras.rep
-- local c = ls.choice_node
-- local types = require "luasnip.util.types"
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local parse = require("luasnip.util.parser").parse_snippet
return {
  s("sysouf", fmt([[System.out.printf("{}", {});]], { i(1), i(0) })),
  s("sysout", fmt([[System.out.print({});]], { i(0) })),
  s("sysoul", fmt([[System.out.println({});]], { i(0) })),
  s("main",
    fmt(
      [[
        public static void main(String[] args) {{
            {}
        }}
      ]],
      { i(0) }
    )),
}
