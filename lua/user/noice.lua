local M = {
  "folke/noice.nvim",
  commit = "6c87c1d11c38180fb72bf8f45518a0a3e081afc1",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    {
      "MunifTanjim/nui.nvim",
      commit = "d146966a423e60699b084eeb28489fe3b6427599",
    },
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      "rcarriga/nvim-notify",
      commit = "ea9c8ce7a37f2238f934e087c255758659948e0f",
    },
  },
}

local get_icon = require("utils.icons").get_icon

M.opts = {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  -- presets = {
  --   bottom_search = true, -- use a classic bottom cmdline for search
  --   command_palette = true, -- position the cmdline and popupmenu together
  --   long_message_to_split = true, -- long messages will be sent to a split
  --   inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --   lsp_doc_border = false, -- add a border to hover docs and signature help
  -- },
  messages = { enabled = true },
  cmdline = {
    format = {
      filter = { pattern = "^:%s*!", icon = "$ ", ft = "sh" },
      IncRename = {
        pattern = "^:%s*IncRename%s+",
        icon = get_icon("Rename"),
        conceal = true,
      },
    },
  },
  views = {
    cmdline_popup = {
      border = { style = "rounded" },
      win_options = {
        winblend = 5,
        -- winhighlight = {
        --   Normal = "DiagnosticSignInfo",
        --   IncSearch = "",
        --   Search = "",
        -- },
        cursorline = false,
      },
    },
  },
  popupmenu = {
    enabled = true,
  },
  routes = {
    { view = "notify", filter = { event = "msg_showmode" } },
    { filter = { event = "msg_show", find = "%d+L, %d+B" }, view = "mini" },
    {
      view = "cmdline_output",
      filter = { cmdline = "^:", min_height = 5 },
      -- BUG: will be fixed after https://github.com/neovim/neovim/issues/21044 gets merged
    },
    { filter = { event = "msg_show", find = "; before #" }, opts = { skip = true } },
    { filter = { event = "msg_show", find = "; after #" }, opts = { skip = true } },
    { filter = { event = "msg_show", find = " lines, " }, opts = { skip = true } },
    { filter = { event = "msg_show", find = "go up one level" }, opts = { skip = true } },
    { filter = { event = "msg_show", find = "yanked" }, opts = { skip = false } },
    { filter = { find = "No active Snippet" }, opts = { skip = true } },
    { filter = { find = "waiting for cargo metadata" }, opts = { skip = true } },
  },
  presets = {
    inc_rename = true,
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = "rounded",
  },
}

return M
