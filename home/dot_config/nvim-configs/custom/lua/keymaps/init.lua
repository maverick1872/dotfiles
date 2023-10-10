local map = require('utils').map

map({ 'n', 'v' }, '<Space>', '<Nop>')

-- Map easy exit from insert mode
map('i', 'jk', '<ESC>')
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
map('n', '<leader>pi', require('lazy').install, 'Plugins Install')
map('n', '<leader>ps', require('lazy').home, 'Plugins Status')
map('n', '<leader>pS', require('lazy').sync, 'Plugins Sync')
map('n', '<leader>pu', require('lazy').update, 'Plugins Update')
map('n', '<leader>pU', require('lazy').check, 'Plugins Check Updates')

-- Windows
map('n', '<C-h>', '<C-w>h', 'Move to window to the left')
map('n', '<C-l>', '<C-w>l', 'Move to window to the right')
map('n', '<C-k>', '<C-w>k', 'Move to window to the up')
map('n', '<C-h>', '<C-w>j', 'Move to window to the down')

-- Better visual block indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Better line movement
map('n', '<A-j>', ':m .+1<CR>==', 'Move line down')
map('n', '<A-k>', ':m .-2<CR>==', 'Move line up')
map('i', '<A-j>', '<ESC>:m .+1<CR>==gi', 'Move line down')
map('i', '<A-k>', '<ESC>:m .-2<CR>==gi', 'Move line up')
map('v', '<A-j>', ":m '>+1<CR>gv=gv", 'Move visual selection down line')
map('v', '<A-k>', ":m '<-2<CR>gv=gv", 'Move visual selection down line')

-- Enable replace with yank register
map('v', 'p', '"_dP', 'Replace selected text with yank register')

-- Manage Buffers
map('n', '<leader>c', require('utils.buffer').close, 'Close buffer')
map('n', '<leader>C', require('utils.buffer').close, 'Force close buffer')
map('n', '<S-h>', ':bnext<CR>', 'Next buffer')
map('n', '<S-h>', ':bprevious<CR>', 'Previous buffer')





-- map('n', ']b', require('utils.buffer').nav, 'Next buffer')
-- map('n', '[b', require('utils.buffer').nav, 'Previous buffer')
-- map('n', '<leader>bc', require('utils.buffer').close_all, 'Close all buffers except current')
-- map('n', '<leader>bC', require('utils.buffer').close_all, 'Close all buffers')
-- map('n', '<leader>bl', require('utils.buffer').close_left, 'Close all buffers to the left')
-- map('n', '<leader>bp', require('utils.buffer').prev, 'Previous buffer')
-- map('n', '<leader>br', require('utils.buffer').close_right, 'Close all buffers to the right')
--
-- map('n', '<leader>bs', 'Sort Buffers')
-- map('n', '<leader>bse', function()
--   require('utils.buffer').sort 'extension'
-- end, 'By extension')
-- map('n', '<leader>bsr', function()
--   require('utils.buffer').sort 'unique_path'
-- end, 'By relative path')
-- map('n', '<leader>bsp', function()
--   require('utils.buffer').sort 'full_path'
-- end, 'By full path')
-- map('n', '<leader>bsi', function()
--   require('utils.buffer').sort 'bufnr'
-- end, 'By buffer number')
-- map('n', '<leader>bsm', function()
--   require('utils.buffer').sort 'modified'
-- end, 'By modification')

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
