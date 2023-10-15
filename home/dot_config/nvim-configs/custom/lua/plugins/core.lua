-- Defines plugins that require minimal to no configuraiton
return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- Aesthetic Notifications
  {
    'rcarriga/nvim-notify',
    opts = {
      render = 'compact',
      timeout = 2500,
    }
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  -- { 'rebelot/heirline.nvim' },
}
