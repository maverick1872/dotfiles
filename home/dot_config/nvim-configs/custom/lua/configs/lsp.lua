return {
  bashls = {},
  clangd = {},
  marksman = {},
  dockerls = {},
  eslint = {},
  jsonls = {},
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
  prismals = {},
  rust_analyzer = {},
  sqlls = {},
  terraformls = {},
  tsserver = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = true,
      },
    },
  },
}
