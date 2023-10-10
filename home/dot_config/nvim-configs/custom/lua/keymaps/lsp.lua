local is_available = require 'utils'.is_available
local map = require 'utils'.map

-- Mason Package Manager
if is_available "mason.nvim" then
  map('n', "<leader>pm", "<cmd>Mason<cr>", "Mason Installer" )
  map('n', "<leader>pM", "<cmd>MasonUpdateAll<cr>", "Mason Update" )
end

if is_available "mason-lspconfig.nvim" then
  map('n',"<leader>li", "<cmd>LspInfo<cr>", "LSP information" )
end

if is_available "null-ls.nvim" then
  map('n',"<leader>lI", "<cmd>NullLsInfo<cr>", "Null-ls information" )
end
