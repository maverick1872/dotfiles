local map = require('utils').map

-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  branch = 'main',
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '^', show_count = true },
      topdelete = { text = 'v' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '^' },
      topdelete = { text = 'v' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 800,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      map('n', '<leader>gP', gs.preview_hunk, 'Preview hunk')
      map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
      map('n', '<leader>gu', gs.undo_stage_hunk, 'Unstage hunk')
      map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
      map('n', '<leader>gR', gs.reset_buffer, 'Reset file')
      map('n', '<leader>gS', gs.stage_buffer, 'Stage buffer')
      map('n', '<leader>gU', gs.reset_buffer_index, 'Unstage buffer')
    end,
  },
}
