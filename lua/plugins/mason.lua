local M = {
  "williamboman/mason.nvim",
  -- commit = "4546dec8b56bc56bc1d81e717e4a935bc7cd6477",
  commit = "41e75af1f578e55ba050c863587cffde3556ffa6",
  cmd = "Mason",
  event = "BufReadPre",
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      commit = "93e58e100f37ef4fb0f897deeed20599dae9d128",
    },
  },
  opts = {
    ui = {
      border = "rounded",
      width = 0.8,
      height = 0.8,
      icons = {
        package_installed = "◍",
        package_pending = "◍",
        package_uninstalled = "◍",
      },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  },
}

function M.config(_, opts)
  local status_ok, mason = pcall(require, "mason")
  if not status_ok then
    return
  end

  mason.setup(opts)
  require("mason-lspconfig").setup {
    ensure_installed = require("utils").servers,
    automatic_installation = true,
  }
end

return M
