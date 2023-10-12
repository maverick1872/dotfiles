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
--   init = function()
--     vim.g.neo_tree_remove_legacy_commands = true
--   end,

  opts = require 'plugins.configs.neotree',
}
