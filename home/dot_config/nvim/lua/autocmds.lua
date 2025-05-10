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
  pattern = expand '~' .. '/.local/share/chezmoi/home/dot_config*',
  callback = function()
    notify('Applying chezmoi changes...')
    vim.cmd 'silent !chezmoi apply --source-path "<afile>:p"'
  end,
})

autoCmd('BufWritePost', {
  pattern = 'schema.prisma',
  callback = function()
    -- Run prisma validate first to check for errors
    notify('Validating Prisma schema...')
    vim.fn.jobstart('npx prisma validate', {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          -- If validation succeeded, run prisma generate
          vim.fn.jobstart('npx prisma generate', {
            on_exit = function(_, gen_exit_code)
              if gen_exit_code == 0 then
                notify('Prisma client generated successfully', 'info')
              else
                notify('Failed to generate Prisma schema', 'error')
              end
            end
          })
        else
          notify('Prisma schema validation failed', 'error')
        end
      end
    })
  end,
  desc = "Validate Prisma schema and generate client on save"
})

-- Enable presentation mode for all node modules
autoCmd('BufReadPost', {
  pattern = '*/node_modules/*',
  callback = function()
    vim.b.was_in_presentation_mode = true
    vim.cmd('PresentationModeEnable')
  end,
  desc = 'Enable presentation mode for files in node_modules',
})

-- Hide diagnostics in all cases when in insert mode
autoCmd('InsertEnter', {
  pattern = '*',
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

-- Re-enable diagnostics when leaving insert mode (unless in presentation mode)
autoCmd('InsertLeave', {
  pattern = '*',
  callback = function()
    if not vim.g.presentation_mode then
      vim.diagnostic.enable(true)
    end
  end,
})

-- Create commands to toggle presentation mode

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
