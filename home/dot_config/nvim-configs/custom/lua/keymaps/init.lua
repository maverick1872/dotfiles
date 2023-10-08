local map = require('utils').map

map({ 'n', 'v' }, '<Space>', '<Nop>')

map('n', '<leader>q', ':conf qall<cr>', 'Quit all (confirm)')
map('n', '<bs>', "<c-^>'”zz", 'Toggle current/previous buffer', { silent = true, noremap = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", 'Move cursor down', { expr = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", 'Move cursor up', { expr = true })
map('n', '<leader>w', '<cmd>w<cr>', 'Save')
map('n', '<leader>q', '<cmd>confirm q<cr>', 'Quit')
map('n', '<leader>n', '<cmd>enew<cr>', 'New File')
map('n', '<C-s>', '<cmd>w!<cr>', 'Force write')
map('n', '<C-q>', '<cmd>qa!<cr>', 'Force quit')
map('n', '|', '<cmd>vsplit<cr>', 'Vertical Split')
map('n', '\\', '<cmd>split<cr>', 'Horizontal Split')

-- Plugin Manager
-- local packageSection = utils.get_icon('Package', 1, true) .. 'Packages')
map('n', '<leader>p', 'Packages')
map('n', '<leader>pi', require('lazy').install, 'Plugins Install')
map('n', '<leader>ps', require('lazy').home, 'Plugins Status')
map('n', '<leader>pS', require('lazy').sync, 'Plugins Sync')
map('n', '<leader>pu', require('lazy').update, 'Plugins Update')
map('n', '<leader>pU', require('lazy').check, 'Plugins Check Updates')

-- Manage Buffers
map('n', '<leader>c', require('utils.buffer').close, 'Close buffer')
map('n', '<leader>C', require('utils.buffer').close, 'Force close buffer')
map('n', ']b', require('utils.buffer').nav, 'Next buffer')
map('n', '[b', require('utils.buffer').nav, 'Previous buffer')
map('n', '>b', require('utils.buffer').move, 'Move buffer tab right')
map('n', '<b', require('utils.buffer').move, 'Move buffer tab left')

map('n', '<leader>b', 'Buffers')
map('n', '<leader>bc', require('utils.buffer').close_all, 'Close all buffers except current')
map('n', '<leader>bC', require('utils.buffer').close_all, 'Close all buffers')
map('n', '<leader>bl', require('utils.buffer').close_left, 'Close all buffers to the left')
map('n', '<leader>bp', require('utils.buffer').prev, 'Previous buffer')
map('n', '<leader>br', require('utils.buffer').close_right, 'Close all buffers to the right')

map('n', '<leader>bs', 'Sort Buffers')
map('n', '<leader>bse', function()
  require('utils.buffer').sort 'extension'
end, 'By extension')
map('n', '<leader>bsr', function()
  require('utils.buffer').sort 'unique_path'
end, 'By relative path')
map('n', '<leader>bsp', function()
  require('utils.buffer').sort 'full_path'
end, 'By full path')
map('n', '<leader>bsi', function()
  require('utils.buffer').sort 'bufnr'
end, 'By buffer number')
map('n', '<leader>bsm', function()
  require('utils.buffer').sort 'modified'
end, 'By modification')

-- Remap for dealing with word wrap
-- map('n', 'k', "v:count == 0 ? 'gk' : 'k'")
-- map('n', 'j', "v:count == 0 ? 'gj' : 'j'")

-- Diagnostic keymaps
-- map('n', '[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
-- map('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')
-- map('n', '<leader>e', vim.diagnostic.open_float, 'Open floating diagnostic message')
-- map('n', '<leader>dl', vim.diagnostic.setloclist, 'Open diagnostics list')




require 'keymaps.comment'
require 'keymaps.lsp'
require 'keymaps.neotree'
require 'keymaps.nvim-dap'
require 'keymaps.telescope'
