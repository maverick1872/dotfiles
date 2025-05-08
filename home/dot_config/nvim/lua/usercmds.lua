local userCmd = vim.api.nvim_create_user_command
local notify = require('utils').notify

userCmd('PresentationModeEnable', function()
  -- Store the previous state when enabling manually
  vim.b.was_in_presentation_mode = true
  vim.g.presentation_mode = true
  vim.diagnostic.enable(false)
  notify("Presentation mode enabled", "info")
end, { desc = 'Enable presentation mode (disables diagnostics)' })

userCmd('PresentationModeDisable', function()
  vim.b.was_in_presentation_mode = false
  vim.g.presentation_mode = false
  vim.diagnostic.enable(true)
  notify("Presentation mode disabled", "info")
end, { desc = 'Disable presentation mode (enables diagnostics)' })

userCmd('PresentationModeToggle', function()
  vim.g.presentation_mode = not vim.g.presentation_mode
  vim.b.was_in_presentation_mode = vim.g.presentation_mode
  vim.diagnostic.enable(not vim.g.presentation_mode)
  notify("Presentation mode " .. (vim.g.presentation_mode and "enabled" or "disabled"), "info")
end, { desc = 'Toggle presentation mode' })

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
