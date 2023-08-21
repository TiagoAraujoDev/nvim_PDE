local M = {
  "hrsh7th/nvim-cmp",
  commit = "cfafe0a1ca8933f7b7968a287d39904156f2c57d",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef",
    },
    {
      "hrsh7th/cmp-buffer",
      commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
    },
    {
      "hrsh7th/cmp-path",
      commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
    },
    {
      "hrsh7th/cmp-cmdline",
      commit = "23c51b2a3c00f6abc4e922dbd7c3b9aca6992063",
    },
    {
      "saadparwaiz1/cmp_luasnip",
      commit = "18095520391186d634a0045dacaa346291096566",
    },
    {
      "L3MON4D3/LuaSnip",
      commit = "9bff06b570df29434a88f9c6a9cea3b21ca17208",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
        commit = "a6f7a1609addb4e57daa6bedc300f77f8d225ab7",
      },
    },
    {
      "hrsh7th/cmp-nvim-lua",
      commit = "f3491638d123cfd2c8048aefaf66d246ff250ca6",
    },
    {
      "onsails/lspkind.nvim",
      commit = "57610d5ab560c073c465d6faf0c19f200cb67e6e",
    },
  },
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
}

function M.config()
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    return
  end

  local luasnip = require "luasnip"
  local lspkind = require "lspkind"
  local get_icon = require("utils.icons").get_icon
  require("snippets").snip_it()

  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  local border_opts = {
    -- border = "single",
    border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
  }

  local kind_icons = {
    -- TODO: Add Array and Boolean icons
    Array = get_icon "Array",
    Boolean = get_icon "Boolean",
    Text = get_icon "Text",
    Method = get_icon "Method",
    Function = get_icon "Function",
    Constructor = get_icon "Constructor",
    Field = get_icon "Field",
    Variable = get_icon "Variable",
    Class = get_icon "Class",
    Interface = get_icon "Interface",
    Module = get_icon "Module",
    Property = get_icon "Property",
    Unit = get_icon "Unit",
    Value = get_icon "Value",
    Enum = get_icon "Enum",
    Keyword = get_icon "Keyword",
    Snippet = get_icon "Snippet",
    Color = get_icon "Color",
    File = get_icon "File",
    Reference = get_icon "Reference",
    Folder = get_icon "Folder",
    EnumMember = get_icon "EnumMember",
    Constant = get_icon "Constant",
    Struct = get_icon "Struct",
    Event = get_icon "Event",
    Operator = get_icon "Operator",
    TypeParameter = get_icon "TypeParameter",
    Codeium = get_icon "Codeium",
    Copilot = get_icon "Copilot",
  }

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert {
      -- ["<C-k>"] = cmp.mapping.select_prev_item(),
      -- ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm { select = true },
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = lspkind.cmp_format {
        symbol_map = kind_icons,
      },
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer", keyword_length = 5 },
      { name = "path" },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
    },
    experimental = {
      ghost_text = true,
    },
  }
end

return M
