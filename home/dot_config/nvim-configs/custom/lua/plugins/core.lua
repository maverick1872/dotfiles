-- Defines plugins that require minimal to no configuraiton
return {
  -- Git related plugins
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
  },
  {
    'tpope/vim-rhubarb',
    event = 'VeryLazy',
  },

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    event = 'VeryLazy',
  },

  -- Auto highlighting text under cursor by LSP, Treesitter, or Regex
  {
    'rrethy/vim-illuminate',
    event = 'VeryLazy',
  },

  -- Autopair
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recomended as each new version will have breaking changes
  },

  -- Treesitter informed code comments
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    version = '^3.x.x',
    main = 'ibl',
    opts = {},
  },

  -- Aesthetic Notifications
  {
    'rcarriga/nvim-notify',
    opts = {
      render = 'compact',
      timeout = 2500,
    },
  },

  -- Code Outline Utility
  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
