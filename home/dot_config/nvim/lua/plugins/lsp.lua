local serverConfigs = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
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
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
    ------ Setup Mason LSPConfig ------
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup()

    ------ Automatic Server Setup ------
    mason_lspconfig.setup_handlers({
      function(server)
        require('utils').notify('setting up lsp server: ' .. server, 'debug')
        local serverConfig = serverConfigs[server]
        if serverConfig == nil then
          lspconfig[server].setup({})
        else
          lspconfig[server].setup(serverConfig)
        end
      end,
    })
  end,
}
