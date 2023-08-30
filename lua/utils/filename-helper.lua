local M = {}

local is_empty = function(text)
  return text == nil or text == ""
end

local get_path_table = function(path)
  if not string.find(path, "/") then
    return path
  end

  local segments = {}
  local delimiter = "/"

  for segment in path:gmatch("[^" .. delimiter .. "]+") do
    table.insert(segments, segment)
  end

  return segments
end

M.setup = function()
  local get_icon = require("utils.icons").get_icon
  local segments = get_path_table(vim.fn.expand "%:.")
  local file_name = segments[#segments] or segments

  local extension = ""
  local file_icon = ""
  local file_icon_color = ""

  if not is_empty(file_name) then
    extension = vim.fn.expand "%:e"

    local default = false
    if is_empty(extension) then
      extension = ""
      default = true
    end
    file_icon, file_icon_color =
      require("nvim-web-devicons").get_icon_color(file_name, extension, { default = default })

    local hl_group = "FileIconColor" .. extension

    if not file_icon then
      file_icon = ""
    end

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })

    local icon = string.format("%%#%s#%s ", hl_group, file_icon)
    local filename = string.format("%%#Normal#%s ", file_name)
    local divider = string.format("%%#WinBar# %s", get_icon("DividerRight", 1))
    local ellipsis = string.format("%%#WinBar# %s", get_icon("Ellipsis", 1))

    local modified = vim.api.nvim_eval_statusline("%m", {}).str == "[+]" and " " .. get_icon("Modified", 1) or ""
    modified = string.format("%%#Normal#%s", modified)

    if #segments == 1 or type(segments) == "string" then
      return " " .. icon .. filename .. modified
    end

    local path_name_table = {}
    for index, value in ipairs(segments) do
      if index == 1 and #segments > 1 then
        table.insert(path_name_table, ellipsis)
      elseif index == #segments then
        goto continue
      end
      table.insert(path_name_table, divider)
      table.insert(path_name_table, value)
      ::continue::
    end

    return table.concat(path_name_table) .. divider .. icon .. filename .. modified
  end
end

return M
