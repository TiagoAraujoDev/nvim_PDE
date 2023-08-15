local M = {
  "nvim-telescope/telescope-ui-select.nvim",
  commit = "62ea5e58c7bbe191297b983a9e7e89420f581369",
}

M.config = function()
  require("telescope").load_extension "ui-select"
end

return M
