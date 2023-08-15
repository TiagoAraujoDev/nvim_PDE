local M = {}

local isempty = function(text)
  return text == nil or text == ""
end

local getFormatPathName = function(path)
  if not string.find(path, "/") then
    return path
  end

  local segments = {}
  local delimiter = "/"

  for segment in path:gmatch("[^" .. delimiter .. "]+") do
    table.insert(segments, segment)
  end

  return segments[#segments - 1] .. "/" .. segments[#segments]
end

M.filename = function()
  local file_name = getFormatPathName(vim.fn.expand "%:.")

  local extension = ""
  local file_icon = ""
  local file_icon_color = ""

  if not isempty(file_name) then
    extension = vim.fn.expand "%:e"

    local default = false
    if isempty(extension) then
      extension = ""
      default = true
    end
    file_icon, file_icon_color =
      require("nvim-web-devicons").get_icon_color(file_name, extension, { default = default })

    local hl_group = "FileIconColor" .. extension

    if not file_icon then
      file_icon = ""
    end

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color, bg = "#282727" })

    local icon = "%#" .. hl_group .. "#" .. file_icon
    local name = "%#" .. "lualine_c_normal" .. "#" .. file_name
    local space = "%#" .. hl_group .. "#" .. " "

    return icon .. space .. name
  end
end

return M
