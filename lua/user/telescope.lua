local M = {
  "nvim-telescope/telescope.nvim",
  commit = "40c31fdde93bcd85aeb3447bb3e2a3208395a868",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = {
    {
      "ahmedkhalf/project.nvim",
    },
  },
}

local actions = require "telescope.actions"

M.config = function()
  require("telescope").setup {
    defaults = {
      -- prompt_prefix = "  ",
      prompt_prefix = "  ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules" },
      mappings = {
        i = {
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
          -- selection_caret = " ",
        },
      },
    },
  }

  require("telescope").load_extension "ui-select"
end

return M
