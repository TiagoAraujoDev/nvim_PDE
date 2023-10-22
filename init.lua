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

  -- Disable some unnacessary providers
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_python3_provider = 0
  vim.g.loaded_perl_provider = 0
end
