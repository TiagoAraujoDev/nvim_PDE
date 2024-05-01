local M = {
  "nvim-treesitter/nvim-treesitter",
  commit = "226c1475a46a2ef6d840af9caa0117a439465500",
  event = "BufReadPre",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      commit = "729d83ecb990dc2b30272833c213cc6d49ed5214",
    },
    {
      "nvim-tree/nvim-web-devicons",
    },
  },
}
function M.config()
  local status_ok, _ = pcall(require, "nvim-treesitter")
  if not status_ok then
    return
  end
  local configs = require "nvim-treesitter.configs"

  vim.filetype.add {
    extension = {
      mdx = "mdx",
    },
  }

  vim.treesitter.language.register("markdown", "mdx")

  configs.setup {
    ensure_installed = {
      "lua",
      "go",
      "javascript",
      "typescript",
      "tsx",
      "prisma",
      "json",
      "css",
      "html",
      "astro",
      "java",
      "markdown",
      "bash",
      "dockerfile",
      "python",
    }, -- put the language you want in this array
    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "" }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      -- disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }
end

return M
