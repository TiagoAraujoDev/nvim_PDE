local M = {}

M.snip_it = function()
  local status_ok, ls = pcall(require, "luasnip")
  if not status_ok then
    return
  end

  local types = require "luasnip.util.types"
  -- local s = ls.snippet
  -- local sn = ls.snippet_node
  -- local t = ls.text_node
  -- local i = ls.insert_node
  -- local c = ls.choice_node
  -- local f = ls.function_node
  -- local d = ls.dynamic_node
  -- local fmt = require("luasnip.extras.fmt").fmt
  -- local extras = require "luasnip.extras"
  -- local rep = extras.rep

  ls.config.set_config {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = false,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    enable_autosnippets = true,

    -- ext_opts = nil,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { " « <C-l> to choice", "CursorLine" } },
        },
      },
    },
  }

  ls.add_snippets("lua", require("snippets.ft.lua"))
  ls.add_snippets("java", require("snippets.ft.java"))
  ls.add_snippets("typescriptreact", require("snippets.ft.typescriptreact"))
  ls.add_snippets("typescript", require("snippets.ft.typescript"))
  ls.add_snippets("javascript", require("snippets.ft.javascript"))
  ls.add_snippets("cpp", require("snippets.ft.cpp"))

  -- require("luasnip/loaders/from_vscode").lazy_load { include = { "java" } }

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
