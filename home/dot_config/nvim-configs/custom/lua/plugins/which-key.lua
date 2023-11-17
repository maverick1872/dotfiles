-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
    wk.register(opts.defaults)
    -- Register Normal mode labels
    wk.register({
      ['<leader>b'] = 'Buffers',
      ['<leader>l'] = 'LSP',
      ['<leader>p'] = 'Packages',
      ['<leader>g'] = 'Git',
      ['<leader>s'] = 'Search',
    }, { mode = 'n' })
    -- Register Visual mode labels
    wk.register({
      ['<leader>l'] = 'LSP',
    }, { mode = 'v' })
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
