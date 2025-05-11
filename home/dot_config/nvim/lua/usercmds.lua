local notify = require('utils').notify
local map = require('utils').map
local is_available = require('utils').is_available
local userCmd = vim.api.nvim_create_user_command

-- Show unsaved changes in the current buffer
userCmd('ShowUnsavedChanges', function()
  -- Only proceed if buffer is modified
  if vim.bo.modified then
    -- Get the saved content of the file
    local saved_content = vim.fn.readfile(vim.fn.expand('%'))

    -- Create a temporary buffer for to hold the saved contents
    local diff_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(diff_buf, 'Saved Version: ' .. vim.fn.expand('%:t'))
    vim.api.nvim_buf_set_lines(diff_buf, 0, -1, false, saved_content)
    vim.api.nvim_set_option_value('modifiable', false, { buf = diff_buf })

    -- Adds original buffer to diff, creates vertical split, activates saved version buffer, then adds it to the diff as well
    vim.cmd('diffthis')
    vim.cmd('vsplit')
    vim.api.nvim_win_set_buf(0, diff_buf)
    vim.cmd('diffthis')

    -- Add keymapping to the diff buffer only to close it
    map(
      'n',
      'q',
      ':diffoff!<CR>:q!<CR>',
      { noremap = true, silent = true, desc = 'Close diff view', buffer = diff_buf }
    )

    notify('Showing unsaved changes. Press q in the diff window to close it.')
  else
    notify('No unsaved changes in the current buffer.', 'info')
  end
end, {
  desc = 'Show diff between current buffer and saved file',
})

-- local lspFormatGroup = vim.api.nvim_create_augroup('LspFormatting', {})

-- vim.api.nvim_clear_autocmds {
--   group = lspFormatGroup,
--   buffer = bufnr,
-- }
userCmd('FormatBuffer', function(args)
  local formattingDisabled = vim.b.disable_autoformat or vim.g.disable_autoformat
  if formattingDisabled then
    notify('Autoformatting is disabled for this buffer', 'warn')
    return
  end

  local async = not args.bang
  if is_available('conform.nvim') then
    local conform = require('conform')
    conform.format({ async = async })
    return
  end

  -- Fallback to LSP formatting
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.buf.format({ bufnr = bufnr, async = async })
end, { desc = 'Format the current buffer, use ! for sync mode', bang = true })

userCmd('PresentationModeEnable', function()
  -- Store the previous state when enabling manually
  vim.b.presentation_mode = true
  vim.g.presentation_mode = true
  vim.diagnostic.enable(false)
  notify('Presentation mode enabled', 'info')
end, { desc = 'Enable presentation mode' })

userCmd('PresentationModeDisable', function()
  vim.b.presentation_mode = false
  vim.g.presentation_mode = false
  vim.diagnostic.enable(true)
  notify('Presentation mode disabled', 'info')
end, { desc = 'Disable presentation mode' })

userCmd('PresentationModeToggle', function(args)
  if args.bang then
    -- PresentationModeToggle! will disable presentation mode for all buffers
    if vim.g.presentation_mode then
      vim.cmd('PresentationModeDisable')
    else
      vim.cmd('PresentationModeEnable')
    end
    return
  end
  vim.b.presentation_mode = not vim.b.presentation_mode

  local bufnr = vim.api.nvim_get_current_buf()
  vim.diagnostic.enable(true, { nil, bufnr })
end, { desc = 'Toggle presentation mode for current buffer only', bang = true })

userCmd('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for all buffer
    vim.g.disable_autoformat = true
  else
    vim.b.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat',
  bang = true,
})

userCmd('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat',
})
