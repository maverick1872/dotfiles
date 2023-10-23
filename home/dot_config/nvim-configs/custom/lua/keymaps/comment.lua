local is_available = require('utils').is_available
local map = require('utils').map
local comment = require 'Comment.api'

if is_available 'Comment.nvim' then
  map('n', '<leader>/', comment.toggle.linewise.current, 'Toggle comment for current line')
  map('x', '<leader>/', function()
    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'x', false)
    comment.toggle.linewise(vim.fn.visualmode())
  end, 'Toggle comment for selection')
end
