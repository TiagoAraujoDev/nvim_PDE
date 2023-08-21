local M = {
  "ghillb/cybu.nvim",
  commit = "c0866ef6735a85f85d4cf77ed6d9bc92046b5a99",
  event = "BufRead",
  dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
}

M.config = function()
  local status_ok, cybu = pcall(require, "cybu")
  if not status_ok then
    return
  end
  cybu.setup {
    position = {
      relative_to = "win", -- win, editor, cursor
      anchor = "bottomcenter", -- topleft, topcenter, topright,
      -- centerleft, center, centerright,
      -- bottomleft, bottomcenter, bottomright
      vertical_offset = 0, -- vertical offset from anchor in lines
      horizontal_offset = 0, -- vertical offset from anchor in columns
      max_win_height = 5, -- height of cybu window in lines
      max_win_width = 0.5, -- integer for absolute in columns
      -- float for relative to win/editor width
    },
    style = {
      path = "relative", -- absolute, relative, tail (filename only)
      path_abbreviation = "none", -- none, shortened
      border = "rounded", -- single, double, rounded, none
      separator = " ", -- string used as separator
      prefix = "…", -- string used as prefix for truncated paths
      padding = 1, -- left & right padding in number of spaces
      hide_buffer_id = true, -- hide buffer IDs in window
      devicons = {
        enabled = true, -- enable or disable web dev icons
        colored = true, -- enable color for web dev icons
        truncate = true, -- truncate wide icons to one char width
      },
      highlights = { -- see highlights via :highlight
        current_buffer = "CybuFocus", -- current / selected buffer
        adjacent_buffers = "CybuAdjacent", -- buffers not in focus
        background = "CybuBackground", -- window background
        border = "CybuBorder", -- border of the window
      },
    },
    behavior = { -- set behavior for different modes
      mode = {
        default = {
          switch = "immediate", -- immediate, on_close
          view = "rolling", -- paging, rolling
        },
        last_used = {
          switch = "on_close", -- immediate, on_close
          view = "paging", -- paging, rolling
        },
        auto = {
          view = "rolling", -- paging, rolling
        },
      },
      show_on_autocmd = false, -- event to trigger cybu (eg. "BufEnter")
    },
    display_time = 2000, -- time the cybu window is displayed
    exclude = { -- filetypes, cybu will not be active
      "neo-tree",
      "fugitive",
      "qf",
    },
    filter = {
      unlisted = true, -- filter & fallback for unlisted buffers
    },
    fallback = function() end, -- arbitrary fallback function
    -- used in excluded filetypes
  }
  vim.keymap.set("n", "J", "<Plug>(CybuNext)", { desc = "Next buffer" })
  vim.keymap.set("n", "K", "<Plug>(CybuPrev)", { desc = "Previous buffer" })
end

return M
