local formatters = {
  'eslint_d', -- Daemonized Eslint
  'prettierd', -- Daemonized Prettier
  'shfmt', -- Shell (sh/bash/mksh)
  'stylua', -- Lua
  'taplo', -- TOML
  'yamlfmt', -- Yaml
}

local linters = {
  'luacheck', -- Lua
  'yamllint', -- Yaml
  'flake8',
  'mypy',
  'shellcheck',
  'markdownlint',
  'yamllint',
  'jsonlint',
  'hadolint',
  'tflint',
}

return {
  'mason-org/mason.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- 'mason-tool-installer' should be replaced when automatic installation of
    -- all tools is included in the core 'williamboman/mason.nvim' plugin.
    -- Ref issue #103
    'WhoIsSethDaniel/mason-tool-installer.nvim',
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
    -- https://mason-registry.dev/registry/list
    vim.list_extend(tools, formatters)
    vim.list_extend(tools, linters)

    require('mason-tool-installer').setup({
      run_on_start = true,
      ensure_installed = tools,
    })
  end,
}
