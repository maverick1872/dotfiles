-- Add on-attach, capabilities, filetypes here as well under each lsp

return {
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
  tsserver = {
    -- on_attach = function (client)
    --   client.resovled.capabilities.document_formatting = false
    -- end,
    settings = {
      documentformatting = false, -- This can also be applied during on_attach
    }
  },
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = true,
      },
    },
  },
}
