local is_available = require 'utils'.is_available
local map = require 'utils'.map

if is_available "mason-lspconfig.nvim" then
  map('n',"<leader>li", "<cmd>LspInfo<cr>", "LSP information" )
end

if is_available "null-ls.nvim" then
  map('n',"<leader>lI", "<cmd>NullLsInfo<cr>", "Null-ls information" )
end
