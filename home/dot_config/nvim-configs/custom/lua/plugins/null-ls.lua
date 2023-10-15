local lspFormatGroup = vim.api.nvim_create_augroup('LspFormatting', {})

return {
  'jose-elias-alvarez/null-ls.nvim',
  -- event = { "BufReadPre", "BufNewFile" },
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
            buffer = vim.api.nvim_create_autocmd('BufWritePre', {
              group = lspFormatGroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            }),
          }
        end
      end,
    }
  end,
}
