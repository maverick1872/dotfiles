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
      -- ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      -- ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      -- ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      -- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
      -- ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      -- ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      -- ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    })
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
