local M = {
  "kevinhwang91/nvim-ufo",
  commit = "43e39ec74cd57c45ca9d8229a796750f6083b850",
  event = "VimEnter",
  dependencies = {
    {
      "kevinhwang91/promise-async",
      commit = "e94f35161b8c5d4a4ca3b6ff93dd073eb9214c0e",
    },
  },
}

M.config = function()
  local status_ok, ufo = pcall(require, "ufo")
  if not status_ok then
    return
  end
  ufo.setup {
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  }
end

return M
