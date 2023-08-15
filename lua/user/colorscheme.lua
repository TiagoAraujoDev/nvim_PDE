local colorscheme_table = {
  tokyonight = {
    plugin = "tokyonight",
    name = "tokyonight-night",
    repo = "folke/tokyonight.nvim",
    commit = "e52c41314e83232840d6970e6b072f9fba242eb9",
  },
  kanagawa = {
    plugin = "kanagawa",
    name = "kanagawa-dragon",
    repo = "rebelot/kanagawa.nvim",
    commit = "1749cea392acb7d1548a946fcee1e6f1304cd3cb",
  },
}

local colorscheme_selected = colorscheme_table.kanagawa

local M = {
  colorscheme_selected.repo,
  commit = colorscheme_selected.commit,
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = colorscheme_selected.name
function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
