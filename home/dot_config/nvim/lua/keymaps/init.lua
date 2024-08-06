local map = require('utils').map
local is_available = require('utils').is_available
local gs = require 'gitsigns'

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
map('n', '<leader>pi', require('lazy').install, 'Plugins Install')
map('n', '<leader>pS', require('lazy').sync, 'Plugins Sync')
map('n', '<leader>ps', require('lazy').home, 'Plugins Status')
map('n', '<leader>pu', require('lazy').update, 'Plugins Update')
map('n', '<leader>pU', require('lazy').check, 'Plugins Check Updates')

-- Windows/Splits
map('n', '<C-h>', '<C-w>h', 'Go to window to the left')
map('n', '<C-j>', '<C-w>j', 'Go to window below')
map('n', '<C-k>', '<C-w>k', 'Go to window above')
map('n', '<C-l>', '<C-w>l', 'Go to window to the right')
map('n', '<C-q>', '<C-w>q', 'Close window')

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
map('n', '<leader>c', ':bd<CR>', 'Close buffer')
map('n', '<leader>C', ':silent %bd|e#|bd#<CR>', 'Close other buffers')
map('n', '<S-l>', ':bnext<CR>', 'Next buffer')
map('n', '<S-h>', ':bprevious<CR>', 'Previous buffer')

-- Changes
map('n', '<leader>gj', ']c', 'Next change', { remap = true })
map('n', '<leader>gk', '[c', 'Previous change', { remap = true })
map({ 'n', 'v' }, ']c', function()
  if vim.wo.diff then
    return ']c'
  end
  if is_available 'gitsigns' then
    vim.schedule(function()
      gs.next_hunk()
    end)
  end
  return '<Ignore>'
end, 'Jump to next hunk', { expr = true })
map({ 'n', 'v' }, '[c', function()
  if vim.wo.diff then
    return '[c'
  end
  if is_available 'gitsigns' then
    vim.schedule(function()
      gs.prev_hunk()
    end)
  end
  return '<Ignore>'
end, 'Jump to previous hunk', { expr = true })

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
require 'keymaps.scratch'
