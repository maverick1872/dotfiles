local userCmd = vim.api.nvim_create_user_command
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
    vim.cmd 'silent !chezmoi apply --source-path "<afile>:p"'
  end,
})

-- Enable presentation mode for all node modules
autoCmd('BufReadPost', {
  pattern = '*/node_modules/*',
  callback = function()
    vim.g.presentation_mode = true
    vim.diagnostic.enable(false)
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
-- autoCmd('InsertLeave', {
--   pattern = '*',
--   callback = function()
--     if not vim.g.presenation_mode then
--       vim.diagnostic.enable()
--     end
--   end,
-- })

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

userCmd('ListLspCapabilities', function()
  local curBuf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients { bufnr = curBuf }

  for _, client in pairs(clients) do
    if client.name ~= 'null-ls' then
      local capAsList = {}
      for key, value in pairs(client.server_capabilities) do
        if value and key:find 'Provider' then
          local capability = key:gsub('Provider$', '')
          table.insert(capAsList, '- ' .. capability)
        end
      end
      table.sort(capAsList) -- sorts alphabetically
      local msg = '# ' .. client.name .. '\n' .. table.concat(capAsList, '\n')
      notify(msg, 'trace', {
        on_open = function(win)
          local buf = vim.api.nvim_win_get_buf(win)
          vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
        end,
        timeout = 14000,
      })
      vim.fn.setreg('+', 'Capabilities = ' .. vim.inspect(client.server_capabilities))
    end
  end
end, {})

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
