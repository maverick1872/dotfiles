return {
  {
    'olivercederborg/poimandres.nvim',
    enabled = false,
    event = 'VeryLazy',
  },
  {
    'navarasu/onedark.nvim',
    enabled = false,
    event = 'VeryLazy',
  },
  {
    'AlexvZyl/nordic.nvim',
    enabled = false,
    event = 'VeryLazy',
  },
  {
    'AstroNvim/astrotheme',
    lazy = false,
    priority = 1000, -- ensure default colorscheme is loaded first
    opts = {
      palette = 'astrodark',
    },
  },
}
