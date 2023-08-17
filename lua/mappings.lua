local utils = require "utils.mappings-helper"
local maps = utils.empty_map_table()
local get_icon = require("utils.icons").get_icon

local sections = {
  f = { desc = get_icon("Telescope", 1) .. "Telescope" },
  l = { desc = get_icon("Lsp", 1) .. "LSP" },
  b = { desc = get_icon("Bqf", 1) .. "Bqf" },
  g = { desc = get_icon("Git", 1) .. "Git" },
  s = { desc = get_icon("Spectre", 1) .. "Spectre" },
  t = { desc = get_icon("Trouble", 1) .. "Trouble" },
}

-- Normal --
-- Standard Operations
maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>q"] = { "<cmd>confirm q<cr>", desc = "Quit" }
maps.n["<leader>c"] = { "<cmd>Bdelete!<cr>", desc = "Close buffer" }
maps.n["<leader>C"] = { "<cmd>e $MYVIMRC <CR>", desc = "Configuration files" }
maps.n["<leader>a"] = { "<cmd>ene <BAR> startinsert <CR>", desc = "New file" }

maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" }
maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" }

-- Better window navigation
maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }

-- Resize with arrows
maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }

maps.n["<S-l>"] = { "<cmd>bnext<CR>", desc = "Next buffer" }
maps.n["<S-h>"] = { "<cmd>bprevious<CR>", desc = "Previous buffer" }

-- Split window
maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }

-- Clear highlights
maps.n["<leader>h"] = { "<cmd>nohlsearch<cr>", desc = "Disable hl search" }

-- Better paste
maps.v["p"] = { '"_dP', desc = "Better paste" }

-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "Unindent line" }
maps.v[">"] = { ">gv", desc = "Indent line" }

-- Alpha
maps.n["<leader>;"] = {
  function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    if #wins > 1 and vim.api.nvim_get_option_value("filetype", { win = wins[1] }) == "neo-tree" then
      vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
    end
    require("alpha").start(false, require("alpha").default_config)
  end,
  desc = "Home Screen",
}
-- Lazy
maps.n["<leader>L"] = { "<cmd>Lazy<cr>", desc = "Lazy" }

-- Noice
maps.n["<leader>n"] = {
  function()
    require("notify").dismiss()
  end,
  desc = "Dismiss notifications",
}

-- NeoTree
maps.n["<leader>e"] = { "<cmd>Neotree float toggle<cr>", desc = "Toggle Explorer" }
maps.n["<leader>o"] = {
  function()
    if vim.bo.filetype == "neo-tree" then
      vim.cmd.wincmd "p"
    else
      vim.cmd.Neotree "focus"
    end
  end,
  desc = "Toggle Explorer Focus",
}

-- Telescope
maps.n["<leader>f"] = sections.f
maps.n["<leader>f<CR>"] = {
  function()
    require("telescope.builtin").resume()
  end,
  desc = "Resume previous search",
}
maps.n["<leader>f'"] = {
  function()
    require("telescope.builtin").marks()
  end,
  desc = "Find marks",
}
maps.n["<leader>f/"] = {
  function()
    require("telescope.builtin").current_buffer_fuzzy_find()
  end,
  desc = "Find words in current buffer",
}
maps.n["<leader>fb"] = {
  function()
    require("telescope.builtin").buffers()
  end,
  desc = "Find buffers",
}
maps.n["<leader>fc"] = {
  function()
    require("telescope.builtin").grep_string()
  end,
  desc = "Find word under cursor",
}
maps.n["<leader>fC"] = {
  function()
    require("telescope.builtin").commands()
  end,
  desc = "Find commands",
}
maps.n["<leader>ff"] = {
  function()
    require("telescope.builtin").find_files()
  end,
  desc = "Find files",
}
maps.n["<leader>fF"] = {
  function()
    require("telescope.builtin").find_files { hidden = true, no_ignore = true }
  end,
  desc = "Find all files",
}
maps.n["<leader>fh"] = {
  function()
    require("telescope.builtin").help_tags()
  end,
  desc = "Find help",
}
maps.n["<leader>fH"] = {
  function()
    require("telescope.builtin").highlights()
  end,
  desc = "Find highlights",
}
maps.n["<leader>fk"] = {
  function()
    require("telescope.builtin").keymaps()
  end,
  desc = "Find keymaps",
}
maps.n["<leader>fm"] = {
  function()
    require("telescope.builtin").man_pages()
  end,
  desc = "Find man",
}
maps.n["<leader>fn"] = {
  function()
    require("telescope").extensions.notify.notify()
  end,
  desc = "Find notifications",
}
maps.n["<leader>fo"] = {
  function()
    require("telescope.builtin").oldfiles()
  end,
  desc = "Find history",
}
maps.n["<leader>fr"] = {
  function()
    require("telescope.builtin").registers()
  end,
  desc = "Find registers",
}
maps.n["<leader>ft"] = {
  function()
    require("telescope.builtin").colorscheme { enable_preview = true }
  end,
  desc = "Find themes",
}
maps.n["<leader>fw"] = {
  function()
    require("telescope.builtin").live_grep()
  end,
  desc = "Find words",
}
maps.n["<leader>fW"] = {
  function()
    require("telescope.builtin").live_grep {
      additional_args = function(args)
        return vim.list_extend(args, { "--hidden", "--no-ignore" })
      end,
    }
  end,
  desc = "Find words in all files",
}
maps.n["<leader>fp"] = {
  function()
    require("telescope").extensions.projects.projects { initial_mode = "normal"}
  end,
  desc = "Find projects",
}

-- Comment
maps.n["<leader>/"] = {
  function()
    require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
  end,
  desc = "Toggle comment line",
}
maps.v["<leader>/"] = {
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
  desc = "Toggle comment for selection",
}

-- GitSigns
maps.n["<leader>g"] = sections.g
maps.n["]g"] = {
  function()
    require("gitsigns").next_hunk()
  end,
  desc = "Next Git hunk",
}
maps.n["[g"] = {
  function()
    require("gitsigns").prev_hunk()
  end,
  desc = "Previous Git hunk",
}
maps.n["<leader>gl"] = {
  function()
    require("gitsigns").blame_line()
  end,
  desc = "View Git blame",
}
maps.n["<leader>gL"] = {
  function()
    require("gitsigns").blame_line { full = true }
  end,
  desc = "View full Git blame",
}
maps.n["<leader>gp"] = {
  function()
    require("gitsigns").preview_hunk()
  end,
  desc = "Preview Git hunk",
}
maps.n["<leader>gh"] = {
  function()
    require("gitsigns").reset_hunk()
  end,
  desc = "Reset Git hunk",
}
maps.n["<leader>gr"] = {
  function()
    require("gitsigns").reset_buffer()
  end,
  desc = "Reset Git buffer",
}
maps.n["<leader>gs"] = {
  function()
    require("gitsigns").stage_hunk()
  end,
  desc = "Stage Git hunk",
}
maps.n["<leader>gS"] = {
  function()
    require("gitsigns").stage_buffer()
  end,
  desc = "Stage Git buffer",
}
maps.n["<leader>gu"] = {
  function()
    require("gitsigns").undo_stage_hunk()
  end,
  desc = "Unstage Git hunk",
}
maps.n["<leader>gd"] = {
  function()
    require("gitsigns").diffthis()
  end,
  desc = "View Git diff",
}

-- Harpoon
maps.n["mm"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Mark file" }
maps.n["<TAB>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Toggle harpoon" }
maps.n["]h"] = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", desc = "Next harpoon" }
maps.n["[h"] = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", desc = "Previous harpoon" }

-- UFO
maps.n["zR"] = {
  function()
    require("ufo").openAllFolds()
  end,
  desc = "Open all folds",
}
maps.n["zM"] = {
  function()
    require("ufo").closeAllFolds()
  end,
  desc = "Close all folds",
}
maps.n["zr"] = {
  function()
    require("ufo").openFoldsExceptKinds()
  end,
  desc = "Fold less",
}
maps.n["zm"] = {
  function()
    require("ufo").closeFoldsWith()
  end,
  desc = "Fold more",
}
maps.n["zp"] = {
  function()
    require("ufo").peekFoldedLinesUnderCursor()
  end,
  desc = "Peek fold",
}

--  BQF
maps.n["<leader>b"] = sections.b
maps.n["<leader>bo"] = {
  "<cmd>copen<cr>",
  desc = "Open bqf",
}
maps.n["<leader>bc"] = {
  "<cmd>cclose<cr>",
  desc = "Close bqf",
}

-- Spectre
maps.n["<leader>s"] = sections.s
maps.n["<leader>ss"] = { '<cmd>lua require("spectre").toggle()<CR>', desc = "Open spectre" }
maps.n["<leader>sw"] =
  { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Spectre in current word" }
maps.v["<leader>sw"] = { '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Spectre in current word" }
maps.n["<leader>sf"] =
  { '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Spectre current file" }

-- Trouble
maps.n["<leader>t"] = sections.t
maps.n["<leader>tt"] = { "<cmd>TroubleToggle<cr>", desc = "Toggle trouble" }
maps.n["<leader>tw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Toggle workspace diagnostics" }
maps.n["<leader>td"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Toggle document diagnostics" }
maps.n["<leader>tq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Toggle quickfix" }
maps.n["<leader>tR"] = { "<cmd>TroubleToggle lsp_references<cr>", desc = "Toggle lsp references" }

-- LSP
maps.n["<leader>l"] = sections.l
maps.n["<leader>lf"] = { "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", desc = "Format file" }

utils.set_mappings(maps)
