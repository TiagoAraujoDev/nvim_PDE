local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require "luasnip.extras"
local rep = extras.rep
local c = ls.choice_node
local sn = ls.snippet_node
-- local t = ls.text_node
-- local types = require "luasnip.util.types"
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local parse = require("luasnip.util.parser").parse_snippet

return {
  s("cl", fmt([[console.log({});]], { i(0, "value") })),
  s(
    "import",
    fmt([[import {} from "{}";]], {
      c(1, {
        sn(nil, fmt("{}", i(1))),
        sn(nil, fmt("{{ {} }}", i(1))),
      }),
      i(0, "module"),
    })
  ),
  s(
    "class",
    fmt(
      [[
    class {} {{
      constructor({}) {{}};
      
      {}
    }}

    export {{ {} }};
    ]],
      {
        i(1, "class_name"),
        i(2),
        i(0),
        rep(1),
      }
    )
  ),
  s(
    "func",
    fmt(
      [[
    function {}({}) {{
      {}
    }}

    export {{ {} }};
    ]],
      {
        i(1, "func_name"),
        i(2),
        i(0),
        rep(1),
      }
    )
  ),
  s(
    "interface",
    fmt(
      [[
        interface {} {{
          {}
        }}
        ]],
      {
        i(1, "name"),
        i(0),
      }
    )
  ),
}
