local autoGrp = vim.api.nvim_create_augroup
local autoCmd = vim.api.nvim_create_autocmd
local expand = vim.fn.expand

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
  end
})
