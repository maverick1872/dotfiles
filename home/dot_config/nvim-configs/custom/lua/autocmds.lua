local autoCmd = vim.api.nvim_create_autocmd
local autoGrp = vim.api.nvim_create_augroup
local expand = vim.fn.expand
local notify = require('utils').notify

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = autoGrp('YankHighlight', { clear = true })
autoCmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Moves the help window to the far right
autoCmd('FileType', {
  pattern = 'help',
  command = 'wincmd L',
})

-- Auto apply chezmoi source to target when written
autoCmd('BufWritePost', {
  pattern = expand '~' .. '/.local/share/chezmoi/*',
  callback = function()
    vim.cmd 'silent !chezmoi apply --source-path "<afile>:p"'
  end,
})

autoCmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function()
    vim.opt_local.number = true
  end,
})

autoCmd('User', {
  pattern = 'MasonToolsStartingInstall',
  callback = function()
    notify 'Installing tools via MasonToolsInstaller'
  end,
})

autoCmd('User', {
  pattern = 'MasonToolsUpdateCompleted',
  callback = function(e)
    -- TODO: This doesn't work; let's revisit
    if not next(e.data) == nil then
      notify(vim.inspect(e.data))
    end
  end,
})

autoCmd('LspAttach', {
  callback = require 'keymaps.lsp',
})
