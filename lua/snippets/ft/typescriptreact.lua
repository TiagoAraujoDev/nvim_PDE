local ls = require "luasnip"

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require "luasnip.extras"
local rep = extras.rep
-- local types = require "luasnip.util.types"
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local parse = require("luasnip.util.parser").parse_snippet

return {
  s("cl", fmt([[console.log({})]], { i(0, "value") })),
  s(
    "rfc",
    fmt(
      [[
      import React from "react";
      
      const {}{} = ({}) => {{
        return (
          <div>
            <h1>{}</h1>
          </div>
        );
      }};
      
      export {{ {} }};
      ]],
      {
        i(1, "Component_name"),
        c(2, {
          t "",
          sn(nil, fmt(": React.FC<{}>", i(1))),
        }),
        i(0),
        rep(1),
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
  s(
    "us",
    fmt(
      [[
      const [{}, {}] = useState{}({});
      ]],
      {
        i(1, "state"),
        i(2, "dispatch"),
        c(3, {
          t "",
          sn(nil, fmt("<{}>", i(1))),
        }),
        i(0),
      }
    )
  ),
  s(
    "ue",
    fmt(
      [[
      useEffect(() => {{
        {}
      }}, [{}]);
      ]],
      {
        i(0),
        i(1, "dependencies"),
      }
    )
  ),
}
