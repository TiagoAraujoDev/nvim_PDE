local M = {
  "ThePrimeagen/harpoon",
  commit = "c1aebbad9e3d13f20bedb8f2ce8b3a94e39e424a",
  cmd = "Harpoon",
}

M.config = function()
  local status_ok, harpoon = pcall(require, "harpoon")
  if not status_ok then
    return
  end

  harpoon.setup {}
end

return M
