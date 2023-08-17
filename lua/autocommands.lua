local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup
local cmd = vim.cmd

local dashboard = require "alpha.themes.dashboard"

autocmd("BufWinEnter", {
  desc = "Make some windows close with q",
  group = autogroup("quit_q", { clear = true }),
  callback = function(event)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = event.buf })
    if buftype == "nofile" or filetype == "help" then
      vim.keymap.set("n", "q", "<cmd>close<cr>", {
        desc = "Close window",
        buffer = event.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})

local alpha_settings = autogroup("alpha_footer", { clear = true })
vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Configure Alpha footer",
  group = alpha_settings,
  callback = function()
    local get_icon = require("utils.icons").get_icon
    local stats = require("lazy").stats()
    local ms = string.format("%.2f", stats.startuptime)
    dashboard.section.footer.val = {
      " ",
      " ",
      " ",
      get_icon("Bolt", 1) .. "Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms " .. get_icon "Clock",
    }
    dashboard.section.footer.opts.hl = "DashboardFooter"
    pcall(cmd.AlphaRedraw)
  end,
})
autocmd({ "User", "BufEnter" }, {
  desc = "Disable statusline for alpha",
  group = alpha_settings,
  callback = function(event)
    if
      (
        (event.event == "User" and event.file == "AlphaReady")
        or (event.event == "BufEnter" and vim.api.nvim_get_option_value("filetype", { buf = event.buf }) == "alpha")
      ) and not vim.g.before_alpha
    then
      vim.g.before_alpha = { laststatus = vim.opt.laststatus:get() }
      vim.opt.laststatus = 0
    elseif
      vim.g.before_alpha
      and event.event == "BufEnter"
      and vim.api.nvim_get_option_value("buftype", { buf = event.buf }) ~= "nofile"
    then
      vim.opt.laststatus = vim.g.before_alpha.laststatus
      vim.g.before_alpha = nil
    end
  end,
})

autocmd("FileType", {
  desc = "Set wordwrap and spell checking in git and markdown files",
  group = autogroup("wordwrap_spell", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd("VimResized", {
  desc = "Resize tab on window resize",
  group = autogroup("window_resize", { clear = true }),
  callback = function()
    cmd "tabdo wincmd ="
  end,
})

autocmd("TextYankPost", {
  desc = "Configure highlight group and timeout for yank command",
  group = autogroup("highlightyank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 }
  end,
})

autocmd("BufWritePost", {
  desc = "Refresh codelens when open a java file",
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

autocmd("BufWinEnter", {
  desc = "Pause Illuminate on very big files",
  group = autogroup("illuminate_stop", { clear = true }),
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      cmd "IlluminatePauseBuf"
    end
  end,
})

autocmd("BufWinEnter", {
  desc = "Disable automatic comment on insert new line above/bellow with O/o",
  group = autogroup("auto_comment", { clear = true }),
  callback = function()
    cmd "set formatoptions-=cro"
  end,
})

  end,
})
