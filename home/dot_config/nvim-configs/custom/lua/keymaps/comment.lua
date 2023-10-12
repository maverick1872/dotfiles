local is_available = require('utils').is_available
local map = require('utils').map

-- Comment
if is_available 'Comment.nvim' then
  map('n', '<leader>/', function()
    require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
  end, 'Toggle comment line')
  map('v', '<leader>/', function()
    vim.api.nvim_feedkeys('esc', 'nx', false)
    require('Comment.api').toggle.blockwise(vim.fn.visualmode())
  end, 'Toggle comment for selection')



        -- -- Toggle selection (linewise)
        -- vim.keymap.set('x', '<leader>c', function()
        --     vim.api.nvim_feedkeys(esc, 'nx', false)
        --     api.toggle.linewise(vim.fn.visualmode())
        -- end)
        --
        -- -- Toggle selection (blockwise)
        -- vim.keymap.set('x', '<leader>b', function()
        --     vim.api.nvim_feedkeys(esc, 'nx', false)
        --     api.toggle.blockwise(vim.fn.visualmode())
        -- end)
end
