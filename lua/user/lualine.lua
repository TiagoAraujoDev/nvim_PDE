local M = {
  "nvim-lualine/lualine.nvim",
  commit = "0050b308552e45f7128f399886c86afefc3eb988",
  -- event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  event = { "BufReadPre" },
}

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  local get_icon = require("utils.icons").get_icon

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local mode = {
    function()
      local short_mode = vim.api.nvim_get_mode()["mode"]
      local mode

      if short_mode == "n" then
        mode = "Normal"
      elseif short_mode == "i" then
        mode = "Insert"
      elseif short_mode == "v" then
        mode = "Visual"
      elseif short_mode == "V" then
        mode = "V-Block"
      elseif short_mode == "no" then
        mode = "Operator"
      elseif short_mode == "c" then
        mode = "Command"
      else
        mode = "WTF-Mode"
      end

      return get_icon("Vim", 1) .. mode
    end,
    padding = 1,
  }

  -- local filename = {
  --   function()
  --     local helper = require "utils.filename-helper"
  --     local modified = vim.api.nvim_eval_statusline("%m", {}).str == "[+]" and " " .. get_icon("Modified", 1) or ""
  --     return helper.filename() .. modified
  --   end,
  -- }

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = get_icon("Error", 1), warn = get_icon("Warning", 1) },
    colored = true,
    always_visible = true,
  }

  local diff = {
    "diff",
    colored = true,
    symbols = { added = get_icon("LineAdded", 1), modified = get_icon("LineModified", 1), removed = get_icon("LineRemoved", 1) }, -- changes diff symbols
    cond = hide_in_width,
  }

  local lsp = {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      -- local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then
          table.insert(buf_client_names, client.name)
        end
      end

      local unique_client_names = vim.fn.uniq(buf_client_names)

      local language_servers = get_icon("Lsp", 1) .. "LSP: " .. table.concat(unique_client_names, ", ") .. " "

      return language_servers
    end,
    color = { gui = "bold" },
    cond = hide_in_width,
  }

  local treesitter = {
    function()
      local buf = vim.api.nvim_get_current_buf()
      local highlighter = vim.treesitter.highlighter
      if highlighter.active[buf] then
        -- treesitter highlighting is enabled
        return get_icon("Tree", 1) .. "TS"
      end
      return ""
    end,
    color = { fg = "#41a32f" },
  }

  local location = {
    "location",
    padding = 1,
  }

  lualine.setup {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "kanagawa",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { "branch" },
      lualine_c = { diagnostics },
      lualine_x = { diff, lsp, treesitter },
      lualine_y = { location },
      lualine_z = { "progress" },
    },
  }
end

return M
