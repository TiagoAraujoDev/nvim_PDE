local M = {
  "nvim-telescope/telescope.nvim",
  commit = "40c31fdde93bcd85aeb3447bb3e2a3208395a868",
  event = "BufEnter",
  cmd = "Telescope",
  dependencies = {
    {
      "ahmedkhalf/project.nvim",
    },
  },
}

local actions = require "telescope.actions"

M.config = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end
  local get_icon = require("utils.icons").get_icon
  telescope.setup {
    defaults = {
      prompt_prefix = get_icon("Telescope", 2),
      selection_caret = get_icon("Selected", 1),
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
      layout_strategy = "vertical",
      layout_config = {
        height = 0.75,
        width = 0.65,
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
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

  telescope.load_extension "ui-select"
  telescope.load_extension "harpoon"
end

return M
