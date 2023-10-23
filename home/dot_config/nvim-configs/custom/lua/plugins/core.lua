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
    opts = {
      exclude = {
        filetypes = { 'dashboard' },
      },
    },
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

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        mode = 'buffers',
        separator_style = 'slant',
        themable = false,
        show_duplicate_prefix = true,
      },
    },
  },

  -- Start Dashboard
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app',
            key = 'a',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'Telescope dotfiles',
            key = 'd',
          },
        },
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
