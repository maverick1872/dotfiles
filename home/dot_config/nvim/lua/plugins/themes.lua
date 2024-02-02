return {
  {
    'olivercederborg/poimandres.nvim',
    cond = false,
    event = 'VeryLazy',
  },
  {
    'navarasu/onedark.nvim',
    cond = false,
    event = 'VeryLazy',
  },
  {
    'AlexvZyl/nordic.nvim',
    cond = false,
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
