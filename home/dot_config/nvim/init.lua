require('options')

---- Lazy.nvim Installation ----
--     https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---- Lazy.nvim Configuration ----
require('lazy').setup('plugins', {
  performance = {
    rtp = {
      disabled_plugins = { 'netrwPlugin' },
    },
    checker = {
      enabled = true,
      notify = true, -- get a notification when new updates are found
      frequency = 604800, -- check for updates every weekly (7 days)
      check_pinned = false, -- check for pinned packages that can't be updated
    },
  },
})

require('usercmds')
require('autocmds')
require('keymaps')

-- Set colorscheme
vim.cmd('colorscheme astrodark')

vim.cmd('if argc() == 1 && isdirectory(argv(0)) | cd `=argv(0)` | endif')

local is_available = require('utils').is_available
if is_available('nvim-notify') then
  vim.notify = require('notify')
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
