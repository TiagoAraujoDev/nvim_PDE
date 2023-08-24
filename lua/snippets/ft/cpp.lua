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
  s("cout", fmt([[std::cout << {} << std::endl;]], { i(1, "value") })),
  s("cin", fmt([[std::cin >> {};]], { i(1, "variable") })),
  s(
    "main",
    fmt(
      [[
      #include <iostream>
      
      int main(int argc, char *argv[])
      {{
        {}
        return 0;
      }}
      ]],
      { i(1) }
    )
  ),
}
