local M = {
  "kylechui/nvim-surround",
  commit = "10b20ca7d9da1ac8df8339e140ffef94f9ab3b18",
  event = "BufReadPost",
}

M.config = function ()
  local status_ok, surround = pcall(require, "nvim-surround")
  if not status_ok then
    return
  end

  surround.setup {}
end

return M
