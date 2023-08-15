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
  dashboard.section.buttons.val = {
    button("LDR   a", " " .. " New file"),
    button("LDR f f", "󰈞 " .. " Find file"),
    button("LDR f p", " " .. " Find project"),
    button("LDR f w", "󱎸 " .. " Find text"),
    button("LDR   C", " " .. " Configuration"),
    button("LDR   q", " " .. " Quit"),
  }

  dashboard.section.header.opts.hl = "DashboardHeader"
  dashboard.section.buttons.opts.hl = "DashboardCenter"

  dashboard.opts.opts.noautocmd = true
  alpha.setup(dashboard.opts)
end

return M
