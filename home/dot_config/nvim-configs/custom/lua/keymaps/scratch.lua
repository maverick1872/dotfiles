local map = require('utils').map

map('n', '<leader>tn', function()
  vim.cmd 'ScratchWithName'
end, 'Create scratch file')
