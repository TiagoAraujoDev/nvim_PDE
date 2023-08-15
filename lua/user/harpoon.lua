local M = {
  "ThePrimeagen/harpoon",
  commit = "21f4c47c6803d64ddb934a5b314dcb1b8e7365dc",
  event = "BufWinEnter",
}

M.config = function()
  local status_ok, harpoon = pcall(require, "harpoon")
  if not status_ok then
    return
  end

  harpoon.setup()
end

return M
