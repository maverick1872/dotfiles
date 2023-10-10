-- Useful plugin to show you pending keybinds.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
    wk.register({
      ['<leader>b'] = { name = 'Buffers', _ = 'which_key_ignore' },
      ['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
      ['<leader>p'] = { name = 'Packages', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
    })
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
