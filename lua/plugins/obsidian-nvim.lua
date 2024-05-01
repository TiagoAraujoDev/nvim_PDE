local M = {
  "epwalsh/obsidian.nvim",
  commit = "ec0f44e1921d2701bd99a542031d280f1e3930b5",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/obsidian_vault/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/obsidian_vault/**.md"
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/obsidian_vault/",
      },
    },
    mappings = {}
  },
}

return M
