local map = require('utils').map

map('n', '<leader>fn', function()
  vim.cmd 'ScratchWithName'
end, 'Create scratch file')
