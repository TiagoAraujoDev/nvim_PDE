local colorscheme_table = {
  tokyonight = {
    plugin = "tokyonight",
    name = "tokyonight-storm",
    -- name = "tokyonight-night",
    repo = "folke/tokyonight.nvim",
    commit = "e52c41314e83232840d6970e6b072f9fba242eb9",
  },
  kanagawa = {
    plugin = "kanagawa",
    name = "kanagawa-wave",
    -- name = "kanagawa-dragon", -- Darker theme
    repo = "rebelot/kanagawa.nvim",
    commit = "1749cea392acb7d1548a946fcee1e6f1304cd3cb",
  },
}

local colorscheme = "kanagawa" -- Name of the key in the `colorscheme_table` table
local colorscheme_selected = colorscheme_table[colorscheme]

local M = {
  colorscheme_selected.repo,
  commit = colorscheme_selected.commit,
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = colorscheme_selected.name
function M.config()
  require("kanagawa").setup {
    compile = false, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true, bold = false },
    functionStyle = { italic = true, bold = true },
    keywordStyle = { italic = true, bold = true },
    statementStyle = { italic = false, bold = true },
    typeStyle = { bold = false, italic = true },
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = { -- add/modify theme and palette colors
      palette = {},
      theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    -- overrides = function(colors) -- add/modify highlights
    --   return {}
    -- end,
    theme = "wave",
  }

  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
