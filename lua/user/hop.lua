local M = {
  "phaazon/hop.nvim",
  commit = "03f0434869f1f38868618198b5f4f2ab6d39aef2",
  event = "BufWinEnter",
  branch = "v2",
}

M.config = function()
  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    return
  end

  hop.setup()

  local directions = require("hop.hint").HintDirection
  vim.keymap.set("", "s", function()
    hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = false }
  end, { remap = true })
  vim.keymap.set("", "S", function()
    hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = false }
  end, { remap = true })
  -- vim.keymap.set("", "t", function()
  --   hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 }
  -- end, { remap = true })
  -- vim.keymap.set("", "T", function()
  --   hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 }
  -- end, { remap = true })
end

return M
