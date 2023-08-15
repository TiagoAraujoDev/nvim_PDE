local M = {
  "max397574/better-escape.nvim",
  commit = "7031dc734add47bb71c010e0551829fa5799375f",
  event = "InsertEnter",
}

M.config = function()
  local status_ok, better_escape = pcall(require, "better_escape")
  if not status_ok then
    return
  end

  better_escape.setup {
    mapping = { "kj", "jj" }, -- a table with mappings to use
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
    -- example(recommended)
    -- keys = function()
    --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
    -- end,
  }
end

return M
