-- Defines plugins that require minimal to no configuraiton
return {
  -- Git wrapper
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
  },

  -- GitHub integration (open)
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
    opts = {
      mappings = false,
    },
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
      stages = 'slide',
      timeout = 2250,
    },
  },

  -- Code Outline Utility
  {
    'stevearc/aerial.nvim',
    cond = false,
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
    enabled = false,
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

  -- Documentation Generator
  {
    enabled = false,
    'kkoomen/vim-doge',
    event = 'BufEnter',
  },

  -- Scratch files
  {
    'LintaoAmons/scratch.nvim',
    event = 'VeryLazy',
    opts = {
      -- scratch_file_dir = '${XDG_CACHE_HOME}/scratches',
      use_telescope = true,
      window_cmd = 'edit',
      filetypes = { 'ts', 'json', 'sh', 'js' },
      filetype_details = {
        json = {},
      },
    },
  },

  -- Better Marks UX
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    disable = true,
    opts = {
      -- whether to map keybinds or not. default true
      default_mappings = true,
      -- which builtin marks to show. default {}
      builtin_marks = { '.', '<', '>', '^' },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- whether the shada file is updated after modifying uppercase marks. default false
      force_write_shada = false,
      -- how often (in ms) to redraw signs/recompute mark positions.
      -- higher values will have better performance but may cause visual lag,
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      -- disables mark tracking for specific filetypes. default {}
      excluded_filetypes = {},
      -- disables mark tracking for specific buftypes. default {}
      excluded_buftypes = {},
      -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
      -- sign/virttext. Bookmarks can be used to group together positions and quickly move
      -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
      -- default virt_text is "".
      bookmark_0 = {
        sign = '⚑',
        virt_text = 'hello world',
        -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        -- defaults to false.
        annotate = true,
      },
      mappings = {},
    },
  },
}
