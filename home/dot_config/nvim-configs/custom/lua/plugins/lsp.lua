return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'jay-babu/mason-null-ls.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- 'mason-tool-installer' should be replaced when automatic installation of
    -- all tools is included in the core 'williamboman/mason.nvim' plugin.
    -- Ref issue #103
  },
  config = function()
    local lspconfig = require 'lspconfig'
    require('mason').setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    ------ Setup Mason Tool Installer ------
    require('mason-tool-installer').setup {
      -- https://mason-registry.dev/registry/list
      ensure_installed = {
        --- Language Servers ---
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
        'tsserver', -- Typescript/Javascript

        --- Formatters ---
        'eslint_d', -- Daemonized Eslint
        'prettierd', -- Daemonized Prettier
        'rustfmt', -- Rust
        'shfmt', -- Shell (sh/bash/mksh)
        'stylua', -- Lua
        'yamlfmt', -- Yaml
      },
    }

    -- ------ Setup Mason LSPConfig ------
    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup()

    ------ Automatic Server Setup ------
    mason_lspconfig.setup_handlers {
      function(server)
        require('utils').notify('setting up lsp server: ' .. server, 'debug')
        local serverConfig = require('plugins.configs.lsp')[server]
        if serverConfig == nil then
          lspconfig[server].setup {}
        else
          lspconfig[server].setup(serverConfig)
        end
      end,
    }

    ------ Automatic Configuration of Null-ls sources ------
    require('mason-null-ls').setup { handlers = {} }
  end,
}
