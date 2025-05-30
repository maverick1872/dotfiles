require('options')
require('lazy-init')

-- Set colorscheme
vim.cmd('colorscheme astrodark')

vim.cmd('if argc() == 1 && isdirectory(argv(0)) | cd `=argv(0)` | endif')

local is_available = require('utils').is_available
if is_available('nvim-notify') then
  vim.notify = require('notify')
end

require('usercmds')
require('autocmds')
require('keymaps')

vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- Could be '●', '▎', 'x'
    spacing = 4,
  },
  float = {
    prefix = ' -> ', -- Could be '●', '▎', 'x'
    severity_sort = true,
    source = true, -- Or "if_many"
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
