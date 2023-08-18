local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  commit = "60b4a7167c79c7d04d1ff48b55f2235bf58158a7",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9",
    },
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
      diagnostics.eslint_d.with {
        condition = function(utils)
          return utils.root_has_file ".eslintrc.json"
        end,
      },
      formatting.eslint_d.with {
        condition = function(utils)
          return utils.root_has_file ".eslintrc.json"
        end,
      },
      formatting.prettierd.with {
        extra_filetypes = { "toml", "astro" },
        -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        condition = function(utils)
          return utils.root_has_file ".prettierrc.json"
        end,
      },

      -- diagnostics.luacheck,
      formatting.stylua,
      formatting.google_java_format,
      formatting.gofumpt,
      formatting.goimports,
      diagnostics.golangci_lint,

      formatting.black.with { extra_args = { "--fast" } },
      diagnostics.flake8,
    },
  }
end

return M
