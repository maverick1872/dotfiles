return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  -- TODO: possible additions would be:
  -- cmp-npm
  -- search nvim-cmp repo for aditional sources
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-git',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'zbirenbaum/copilot.lua', -- OSS Copilot rewrite in Lua
    'zbirenbaum/copilot-cmp', -- Copilot CMP source
  },
  config = require 'plugins.configs.completions',
}
