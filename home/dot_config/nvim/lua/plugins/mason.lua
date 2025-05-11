local languageServers = {
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
}

local formatters = {
  'eslint_d', -- Daemonized Eslint
  'prettierd', -- Daemonized Prettier
  'shfmt', -- Shell (sh/bash/mksh)
  'stylua', -- Lua
  'yamlfmt', -- Yaml
}

local linters = {
  'luacheck', -- Lua
}

return {
  'williamboman/mason.nvim',
  event = 'VeryLazy',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- 'mason-tool-installer' should be replaced when automatic installation of
    -- all tools is included in the core 'williamboman/mason.nvim' plugin.
    -- Ref issue #103
  },
  config = function()
    require('mason').setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    ------ Setup Mason Tool Installer ------
    local tools = {}
    vim.list_extend(tools, languageServers)
    vim.list_extend(tools, formatters)
    vim.list_extend(tools, linters)

    require('mason-tool-installer').setup({
      run_on_start = true,
      -- https://mason-registry.dev/registry/list
      ensure_installed = tools,
      -- ensure_installed = {
      --   --- Language Servers ---
      --   'jsonls', -- JSON
      --   'marksman', -- Markdown
      --   'prismals', -- Prisma ORM
      --   'rust_analyzer', -- Rust
      --   'sqlls', -- SQL
      --   'volar', -- Vue
      --   'yamlls', -- YAML
      --   'terraformls', -- Terraform
      --   'bashls', -- Bash (minimal support for ZSH)
      --   'lua_ls', -- Lua
      --   'dockerls', -- Docker
      --   'ts_ls', -- Typescript/Javascript
      --   'helm-ls', -- Helm
      --
      --   --- Formatters ---
      --   'eslint_d', -- Daemonized Eslint
      --   'prettierd', -- Daemonized Prettier
      --   'shfmt', -- Shell (sh/bash/mksh)
      --   'stylua', -- Lua
      --   'yamlfmt', -- Yaml
      --
      --   --- Linters ---
      --   'luacheck', -- Lua
      -- },
    })
  end,
}
