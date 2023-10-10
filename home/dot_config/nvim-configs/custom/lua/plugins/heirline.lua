return {
  'rebelot/heirline.nvim',
  event = 'BufEnter',
  enabled = 'false',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = require('configs.heirline').Opts,
  -- config = require 'configs.heirline',
}
