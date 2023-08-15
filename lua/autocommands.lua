local dashboard = require "alpha.themes.dashboard"

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Close some windows with 'q'",
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Configure Alpha footer",
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
    pcall(vim.cmd.AlphaRedraw)
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Set wordwrap and spell checking in git and markdown files",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Resize tab on window resize",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Configure highlight group and timeout for yank command",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  desc = "Refresh codelens when open a java file",
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  desc = "Set formatoptions to not autocomment on new line",
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- HACK:
-- Illuminate highlight Fix
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd [[ 
      hi LspReferenceRead gui=NONE guibg=#424A56
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd [[ 
      hi LspReferenceWrite gui=NONE guibg=#424A56
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd [[ 
      hi LspReferenceText gui=NONE guibg=#424A56
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd [[ 
      hi IlluminatedWordRead gui=NONE guibg=#424A56
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd [[ 
      hi IlluminatedWordWrite gui=NONE guibg=#424A56
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd [[ 
      hi IlluminatedWordText gui=NONE guibg=#424A56
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd [[ 
      hi link illuminatedWord LspReferenceText
    ]]
  end,
})
