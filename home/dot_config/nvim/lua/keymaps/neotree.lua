local map = require('utils').map
local is_available = require('utils').is_available

-- NeoTree
if is_available('neo-tree.nvim') then
  map('n', '<leader>e', '<cmd>Neotree toggle<cr>', 'Toggle Explorer')
  map('n', '<leader>o', function()
    if vim.bo.filetype == 'neo-tree' then
      vim.cmd.wincmd('p')
    else
      vim.cmd.Neotree('focus')
    end
  end, 'Toggle Explorer Focus')
end
