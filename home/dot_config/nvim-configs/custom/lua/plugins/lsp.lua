return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    "jay-babu/mason-null-ls.nvim",
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
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
          }
      }
    }

    ------ Setup Mason Tool Installer ------
    require('mason-tool-installer').setup {
      -- auto_update = true,
      -- run_on_start = false,
      -- start_delay = 2000, -- 3 second delay
      -- debounce_hours = 168, -- at least 5 hours between attempts to install/update
      -- https://mason-registry.dev/registry/list
      ensure_installed = {
        --- Language Servers ---
        'clangd',
        'jsonls',
        'marksman',
        'prismals',
        'rust_analyzer',
        'sqlls',
        'volar',
        'yamlls',
        'terraformls',
        'bashls',
        'lua_ls',
        'dockerls',
        'tsserver',
        --- Formatters ---
        'clang-format',
        'eslint_d',
        'eslint',
        'prettier',
        'prettierd',
        'shfmt',
        'stylua',
        'yamlfmt',
      },
    }

    -- ------ Setup Mason LSPConfig ------
    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup()

    ------ Automatic Server Setup ------ 
    mason_lspconfig.setup_handlers {
      function(server)
        local serverConfig = require('plugins.configs.lsp')[server]
        if serverConfig == nil then
          lspconfig[server].setup({})
        else
          lspconfig[server].setup(serverConfig)
        end
      end,
    }

    ------ Automatic Configuration of Null-ls sources ------
    require('mason-null-ls').setup { handlers = {} }
  end,
}
