local M = {
  "nvim-neorg/neorg",
  commit = "bf3daa2229c60f92f48ac6d7db3049b65fd01371",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Neorg"
}

M.config = function()
  local status_ok, neorg = pcall(require, "neorg")
  if not status_ok then
    return
  end

  neorg.setup {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.export"] = {}, -- export files to another type .e.g md
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        }
      },
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/notes",
          },
        },
      },
    },
  }
end

return M
