-- Remap functions
function Vscode_terminalToogle()
	vim.fn.VSCodeNotify("workbench.action.terminal.toggleTerminal")
end
function Vscode_multiCursor()
	vim.fn.VSCodeNotify("editor.action.addSelectionToNextFindMatch")
end
function Vscode_comment()
	vim.fn.VSCodeNotify("editor.action.commentLine")
end
function Vscode_blockComment()
	vim.fn.VSCodeNotify("editor.action.blockComment")
end
function Vscode_saveFile()
	vim.fn.VSCodeNotify("workbench.action.files.save")
end
function Vscode_closeEditor()
	vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
end
function Vscode_showHover()
	vim.fn.VSCodeNotify("editor.action.showHover")
end
function Vscode_error()
	vim.fn.VSCodeNotify("editor.action.marker.next")
end
function Vscode_prevTab()
	vim.fn.VSCodeNotify("workbench.action.previousEditor")
end
function Vscode_nextTab()
	vim.fn.VSCodeNotify("workbench.action.nextEditor")
end
function Vscode_explorer()
	vim.fn.VSCodeNotify("workbench.view.explorer")
end

vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { silent = true }

-- vim remaps
keymap("v", "p", '"_dP', opts)
keymap("i", "kj", "<esc>", opts)

-- vscode remaps
keymap("v", "<leader>/", Vscode_blockComment)
keymap("n", "<leader>/", Vscode_comment)
keymap("n", "<leader>w", Vscode_saveFile)
keymap("n", "<leader>q", Vscode_closeEditor)
keymap("n", "K", Vscode_showHover)
keymap("n", "gl", Vscode_error)
keymap("n", "H", Vscode_prevTab)
keymap("n", "L", Vscode_nextTab)
keymap("n", "<leader>e", Vscode_explorer)
keymap("v", "<leader>n", Vscode_multiCursor)
keymap("n", "<C-l>", Vscode_terminalToogle)
