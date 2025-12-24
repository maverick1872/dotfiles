return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',

        -- Match your usual behavior:
        '--hidden',
        '--ignore-file',
        os.getenv('RIPGREP_CONFIG_DIR') .. '/ignore',
      },
    },
  },
}
