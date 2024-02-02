local is_available = require('utils').is_available
local map = require('utils').map
local notify = require('utils').notify

map('n', '<leader>ll', function()
  vim.cmd 'ListLspCapabilities'
end, 'Buffer Clients Information')

-- Distraction Free
map('n', '<leader>lp', function()
  vim.diagnostic.config {
    virtual_text = not vim.diagnostic.config.virtual_text,
  }
end, 'Distraction free mode')

-- Mason Package Manager
if is_available 'mason.nvim' then
  map('n', '<leader>pm', '<cmd>Mason<cr>', 'Mason Installer')
  map('n', '<leader>pM', '<cmd>MasonToolsUpdate<cr>', 'Mason Tools Update')
end

if is_available 'mason-lspconfig.nvim' then
  map('n', '<leader>li', '<cmd>LspInfo<cr>', 'LSP information')
end

if is_available 'null-ls.nvim' then
  map('n', '<leader>lI', '<cmd>NullLsInfo<cr>', 'Null-ls information')
end

local lspFormat = function(bufnr)
  local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  -- TODO: Make calls to null-ls protected in case null ls is unavilable
  local available_sources = require('null-ls.sources').get_available
  local attachedSources = available_sources(ft, require('null-ls.methods').internal.FORMATTING)
  local nullLsHasFiletype = #attachedSources > 0

  vim.lsp.buf.format {
    bufnr = bufnr,
    filter = function(client)
      if nullLsHasFiletype then
        return client.name == 'null-ls'
      else
        return true
      end
    end,
  }
end
local lspFormatGroup = vim.api.nvim_create_augroup('LspFormatting', {})

return function(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  local clientConfig = client.config
  local opts = { buffer = bufnr }

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

  if client.supports_method 'textDocument/implementation' then
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation', opts)
  end

  if client.supports_method 'textDocument/declaration' then
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration', opts)
  end

  if client.supports_method 'textDocument/definition' then
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definitions', opts)
  end

  if client.supports_method 'textDocument/hover' then
    map('n', 'K', vim.lsp.buf.hover, 'Hover LSP', opts)
  end

  if client.supports_method 'textDocument/signatureHelp' then
    map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature help', opts)
  end

  -- map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  -- map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  -- map('n', '<space>wl', function()
  --   notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, 'List workspace folders', opts)

  -- map('n', '<space>D', vim.lsp.buf.type_definition, opts)
  if client.supports_method 'textDocument/rename' then
    map('n', '<leader>lr', vim.lsp.buf.rename, 'Rename symbol', opts)
  end

  if client.supports_method 'textDocument/codeAction' then
    map({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, 'Available Code Actions', opts)
  end

  if client.supports_method 'textDocument/diagnostics' then
    map({ 'n', 'v' }, '<leader>ld', vim.diagnostic.open_float, 'Show Diagnostics', opts)
  end

  if client.supports_method 'textDocument/references' then
    map('n', 'gr', vim.lsp.buf.references, 'Go to references', opts)
  end

  if client.supports_method 'textDocument/formatting' then
    map('n', '<space>f', function()
      lspFormat(bufnr)
    end, 'Format file', opts)
    vim.api.nvim_clear_autocmds {
      group = lspFormatGroup,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = lspFormatGroup,
      buffer = bufnr,
      callback = function()
        lspFormat(bufnr)
      end,
    })
  end
end
