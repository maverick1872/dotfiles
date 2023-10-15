local lspFormatGroup = vim.api.nvim_create_augroup('LspFormatting', {})

local lspFormat = function(bufnr)
  local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
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

return {
  'jose-elias-alvarez/null-ls.nvim',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    require('null-ls').setup {
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
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
      end,
    }
  end,
}
