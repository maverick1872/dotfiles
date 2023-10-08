require 'options'

---- Lazy.nvim Installation ----
--     https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

---- Lazy.nvim Configuration ----
require('lazy').setup('plugins', {
  performance = {
    rtp = {
      disabled_plugins = {
        'netrwPlugin',
      },
    },
  },
})

require 'autocmds'
require 'keymaps'

-- Set colorscheme
vim.cmd 'colorscheme poimandres'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
