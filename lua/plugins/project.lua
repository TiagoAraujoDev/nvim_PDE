local M = {
  "ahmedkhalf/project.nvim",
  commit = "685bc8e3890d2feb07ccf919522c97f7d33b94e4",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
    },
  },
}

function M.config()
  local status_ok, project = pcall(require, "project_nvim")
  if not status_ok then
    return
  end

  project.setup {
    detection_methods = { "pattern" },
    -- patterns used to detect root dir, when **"pattern"** is in detection_methods
    patterns = { ".git", "Makefile", "package.json" },
  }

  local telescope = require "telescope"
  telescope.load_extension "projects"
end

return M
