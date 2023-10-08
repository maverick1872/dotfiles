-- return {
--   'nvim-neo-tree/neo-tree.nvim',
--   branch = 'v3.x',
--   dependencies = {
--     'MunifTanjim/nui.nvim',
--     'nvim-lua/plenary.nvim',
--     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
--   },
--   cmd = 'Neotree',
--   init = function()
--     vim.g.neo_tree_remove_legacy_commands = true
--   end,
--   opts = require 'configs.neotree',
-- }



return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  branch = 'v3.x',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<Leader>e", ":Neotree float<CR>" },
  },
  cmd = "Neotree",

  opts = require 'configs.neotree',
  -- opts = { -- make lazy manage your config
  -- },
  --
}
