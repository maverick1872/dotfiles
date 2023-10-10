return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'towolf/vim-helm',
  },
  config = function()
    local lspconfig = require 'lspconfig'
    require('mason').setup {}

    ------ Setup Mason Tool Installer ------
    require('mason-tool-installer').setup {
      auto_update = true,
      run_on_start = true,
      start_delay = 2000, -- 3 second delay
      debounce_hours = 168, -- at least 5 hours between attempts to install/update

      -- https://mason-registry.dev/registry/list
      ensure_installed = {
        -- 'clang-format',
        -- 'prettier',
        -- 'prettierd',
        -- 'shfmt',
        'stylua',
        -- 'yamlfmt',
      },
    }

    ------ Setup Mason LSPConfig ------
    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup {
      automatic_installation = true,

      ensure_installed = {
        -- 'bashls',
        -- 'clangd',
        -- 'dockerls',
        -- 'eslint',
        -- 'jsonls',
        'lua_ls',
        -- 'marksman',
        -- 'prismals',
        -- 'rust_analyzer',
        -- 'sqlls',
        -- 'terraformls',
        -- 'tsserver',
        -- 'volar',
        -- 'yamlls',
      },
    }

    ------ Setup LSP Configurations ------ 
    mason_lspconfig.setup_handlers {
      function(ls)
        lspconfig[ls].setup(require('configs.lsp')[ls])
      end,
    }

    ------ Setup Mason Null-ls ------
    require('mason-null-ls').setup { handlers = {} }
  end,
}
