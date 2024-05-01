local M = {
  "nvimtools/none-ls.nvim",
  event = "BufReadPre",
  commit = "f5632db2491fbe02b54f1a321a98548a8ba2bd15",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9",
    },
    {
      "nvimtools/none-ls-extras.nvim",
      commit = "c7264e9b97a051ccb955ae178b6fb3e0e9936a45"
    }
  },
}

function M.config()
  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    debug = false,
    sources = {
      require("none-ls.diagnostics.eslint_d").with {
        condition = function(utils)
          return utils.root_has_file { ".eslintrc.json", ".eslintrc.js" }
        end,
      },
      require("none-ls.formatting.eslint_d").with {
        condition = function(utils)
          return utils.root_has_file { ".eslintrc.json", ".eslintrc.js" }
        end,
      },
      -- formatting.prettierd.with {
      --   extra_filetypes = { "toml", "astro" },
      --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      --   condition = function(utils)
      --     return utils.root_has_file {  ".prettierrc.json", ".prettierrc" }
      --   end,
      -- },

      -- diagnostics.luacheck,
      formatting.stylua,
      formatting.google_java_format,
      formatting.gofumpt,
      formatting.goimports,
      diagnostics.golangci_lint,

      formatting.black.with { extra_args = { "--fast" } },
      require("none-ls.diagnostics.flake8"),
    },
  }
end

return M
