--[[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ 
NVIM v0.9.2-dev-52+gf0e4d284f
Build type: RelWithDebInfo
LuaJIT 2.1.0-beta3
]]
--

if vim.g.vscode then
  require "vscode.options"
  require "vscode.keymaps"
else
  require "options"
  require "mappings"
  require "Lazy"
  require "autocommands"
  require "highlight"
end
