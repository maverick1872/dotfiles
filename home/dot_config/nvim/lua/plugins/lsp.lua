--[[
===============================================================================
LSP Configuration
===============================================================================

This plugin configures Neovim's built-in Language Server Protocol (LSP) client
to work with various language servers.

Key Features:
- Applies sensible defaults for language servers

Relevant Help Pages:
- :help lsp (Neovim LSP client)
- :help lspconfig.all (available LSP configurations)

External Documentation:
- https://github.com/neovim/nvim-lspconfig
- https://github.com/mason-org/mason-lspconfig.nvim
]]

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    --- Mason LSPConfig is responsible primarily for two things:
    --- 1. It ensures expected LSP servers are installed.
    --- 2. It automatically enables installed servers with vim.lspconfig.enable()
    'mason-org/mason-lspconfig.nvim',
  },
  config = function()
    ------ Setup Mason LSPConfig ------
    require('mason-lspconfig').setup({
      ensure_installed = {
        'jsonls', -- JSON
        'marksman', -- Markdown
        'prismals', -- Prisma ORM
        'rust_analyzer', -- Rust
        'sqlls', -- SQL
        'volar', -- Vue
        'yamlls', -- YAML
        'terraformls', -- Terraform
        'bashls', -- Bash (minimal support for ZSH)
        'lua_ls', -- Lua
        'dockerls', -- Docker
        'ts_ls', -- Typescript/Javascript
        'helm_ls', -- Helm
      },
    })
  end,
}
