return {
  {
    'olivercederborg/poimandres.nvim',
    event = 'VeryLazy',
  },
  {
    'navarasu/onedark.nvim',
    event = 'VeryLazy',
  },
  {
    'AlexvZyl/nordic.nvim',
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
