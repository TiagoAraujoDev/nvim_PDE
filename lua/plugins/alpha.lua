local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
  commit = "dafa11a6218c2296df044e00f88d9187222ba6b0",
}

function M.config()
  local alpha_status_ok, alpha = pcall(require, "alpha")
  if not alpha_status_ok then
    return
  end

  local dashboard_status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
  if not dashboard_status_ok then
    return
  end

  dashboard.section.header.val = {
    "                                                  ",
    "                                                  ",
    "                                                  ",
    "                                                  ",
    "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
    "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
    "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
    "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
    "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "                                                  ",
    "                                                  ",
  }

  local button = require("utils.alpha-helper").alpha_button
  local get_icon = require("utils.icons").get_icon

  dashboard.section.buttons.val = {
    button("LDR   a", get_icon("NewFile", 1) .. " New file"),
    button("LDR f f", get_icon("FindFile", 1) .. " Find file"),
    button("LDR f p", get_icon("Repository", 1) .. " Find project"),
    button("LDR f w", get_icon("FindText", 1) .. " Find text"),
    button("LDR d w", get_icon("Note", 1) .. " Neorg"),
    button("LDR   C", get_icon("Gear", 1) .. " Configuration"),
    button("LDR   q", get_icon("Quit", 1) .. " Quit"),
  }

  dashboard.section.header.opts.hl = "DashboardHeader"
  dashboard.section.buttons.opts.hl = "DashboardCenter"

  dashboard.opts.opts.noautocmd = true
  alpha.setup(dashboard.opts)
end

return M
