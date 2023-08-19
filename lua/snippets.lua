local M = {}

M.snip_it = function()
  local status_ok, ls = pcall(require, "luasnip")
  if not status_ok then
    return
  end

  local s = ls.snippet
  local sn = ls.snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  local c = ls.choice_node
  local fmt = require("luasnip.extras.fmt").fmt
  local types = require "luasnip.util.types"
  local extras = require "luasnip.extras"
  local rep = extras.rep
  -- local f = ls.function_node
  -- local d = ls.dynamic_node
  -- local parse = require("luasnip.util.parser").parse_snippet

  ls.config.set_config {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = false,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    enable_autosnippets = true,

    -- Crazy highlights!!
    -- #vid3
    -- ext_opts = nil,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { " « <C-l> to choice", "CursorLine" } },
        },
      },
    },
  }

  ls.add_snippets("lua", {
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
  })
  ls.add_snippets("java", {
    s("sysouf", fmt([[System.out.printf("{}", {})]], { i(1), i(0) })),
    s("sysoun", fmt([[System.out.print({})]], { i(0) })),
  })
  ls.add_snippets("typescriptreact", {
    s("cl", fmt([[console.log({})]], { i(0, "value") })),
    s(
      "comp",
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
  })

  require("luasnip/loaders/from_vscode").lazy_load { include = { "java", "typescriptreact" } }

  -- Keymaps
  vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true, desc = "Next snippet node" })
  vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true, desc = "Previous snippet node" })
  vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { desc = "Change cmp choice" })
  vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice", { desc = "Select cmp choice" })
end

return M
