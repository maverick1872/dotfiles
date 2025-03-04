local serverConfigs = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.stdpath 'config' .. '/lua'] = true,
          },
        },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },
  jsonls = {
    settings = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}

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
      run_on_start = true,
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
        'ts_ls', -- Typescript/Javascript
        'helm-ls', -- Helm

        --- Formatters ---
        'eslint_d', -- Daemonized Eslint
        'prettierd', -- Daemonized Prettier
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
        local serverConfig = serverConfigs[server]
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
