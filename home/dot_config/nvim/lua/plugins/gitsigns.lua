local map = require('utils').map

-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  branch = 'main',
  opts = {
    -- See `:help gitsigns.txt`
    -- The following is experimental and subject to change
    _signs_staged_enable = true,
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
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
      map('n', '<leader>gS', gs.stage_buffer, 'Stage buffer')
      map('n', '<leader>gU', gs.undo_stage_hunk, 'Unstage buffer')
      map('n', '<leader>gR', gs.reset_buffer, 'Reset buffer')

      -- don't override the built-in and fugitive keymaps
      map({ 'n', 'v' }, ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, 'Jump to next hunk', { expr = true, buffer = bufnr })
      map({ 'n', 'v' }, '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, 'Jump to previous hunk', { expr = true, buffer = bufnr })
    end,
  },
}
