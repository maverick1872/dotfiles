return {
  {
    'olivercederborg/poimandres.nvim',
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require('poimandres').setup {
    --     -- leave this setup function empty for default config
    --     -- or refer to the configuration section
    --     -- for configuration options
    --   }
    -- end,

    -- optionally set the colorscheme within lazy config
    -- init = function()
    --   vim.cmd("colorscheme poimandres")
    -- end
  },
  {
    'navarasu/onedark.nvim',
    opts = {
      style = 'warmer',
    },
    lazy = false,
    priority = 1000, -- Ensure it loads first
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nordic').load()
    end,
  },
  {
    'AstroNvim/astrotheme',
    opts = {
      palette = "astrodark",
    },
  },
}
