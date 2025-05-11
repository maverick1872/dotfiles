local is_available = require('utils').is_available
local map = require('utils').map
local notify = require('utils').notify

map('n', '<leader>ll', function()
  vim.cmd('ListLspCapabilities')
end, 'Buffer Clients Information')

-- Presentation mode
map('n', '<leader>lp', function()
  vim.cmd('PresentationModeToggle')
end, 'Presentation mode toggle for buffer')

map('n', '<leader>lp', function()
  vim.cmd('PresentationModeToggle!')
end, 'Presentation mode toggle')

-- Treesitter
if is_available('nvim-treesitter') then
  map('n', '<leader>pt', '<cmd>TSUpdate<cr>', 'Treesitter Update')
end

-- Mason Package Manager
if is_available('mason.nvim') then
  map('n', '<leader>pm', '<cmd>Mason<cr>', 'Mason Installer')
  map('n', '<leader>pM', '<cmd>MasonToolsUpdate<cr>', 'Mason Tools Update')
end

if is_available('mason-lspconfig.nvim') then
  map('n', '<leader>li', '<cmd>LspInfo<cr>', 'LSP information')
end

return function(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if not client then
    notify('No client config found for ' .. args.data.client_id, 'warn')
    return
  end

  local clientConfig = client.config
  notify(client.name .. ' config: ' .. vim.inspect(clientConfig), 'debug')
  if clientConfig.capabilities then
    local capabilities = {}
    for type, val in pairs(clientConfig.capabilities) do
      for k, _ in pairs(val) do
        table.insert(capabilities, k)
      end
      notify(client.name .. ' ' .. type .. ': ' .. vim.inspect(capabilities), 'debug')
    end
  end

  local opts = { buffer = bufnr }
  if client:supports_method('textDocument/implementation') then
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation', opts)
  end

  if client:supports_method('textDocument/declaration') then
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration', opts)
  end

  if client:supports_method('textDocument/definition') then
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definitions', opts)
  end

  if client:supports_method('textDocument/hover') then
    map('n', 's', vim.lsp.buf.hover, 'Hover LSP', opts)
  end

  if client:supports_method('textDocument/signatureHelp') then
    map('n', 'gs', vim.lsp.buf.signature_help, 'Signature help', opts)
  end

  -- map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  -- map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  -- map('n', '<space>wl', function()
  --   notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, 'List workspace folders', opts)

  -- map('n', '<space>D', vim.lsp.buf.type_definition, opts)
  if client:supports_method('textDocument/rename') then
    map('n', '<leader>lr', vim.lsp.buf.rename, 'Rename symbol', opts)
  end

  if client:supports_method('textDocument/codeAction') then
    map({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, 'Available Code Actions', opts)
  end

  if client:supports_method('textDocument/diagnostics') then
    map({ 'n', 'v' }, '<leader>ld', vim.diagnostic.open_float, 'Show Diagnostics', opts)
  end

  if client:supports_method('textDocument/references') then
    map('n', 'gr', vim.lsp.buf.references, 'Go to references', opts)
  end

  if client:supports_method('textDocument/formatting') then
    map('n', '<space>lf', function()
      vim.cmd('FormatBuffer')
    end, 'Format file', opts)
  end
end
