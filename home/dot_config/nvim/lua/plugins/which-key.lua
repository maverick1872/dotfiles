-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 400,
    notify = true,
    icons = { mappings = false },
    spec = {
      { '<leader>b', group = 'Buffers' },
      { '<leader>l', group = 'LSP' },
      { '<leader>p', group = 'Packages' },
      { '<leader>g', group = 'Git' },
      { '<leader>s', group = 'Search' },
      { '<leader>su', group = 'Search Unrestricted' },
      { '<leader>t', group = 'Temp (scratch) Files' },
      { '<leader>l', group = 'LSP', mode = 'v' },
    },
  },
}
