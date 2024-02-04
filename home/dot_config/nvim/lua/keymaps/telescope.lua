local map = require('utils').map
local is_available = require('utils').is_available
if is_available 'telescope.nvim' then
  map('n', '<leader>ss', require('telescope.builtin').resume, 'Resume previous search')
  map('n', '<leader>sk', require('telescope.builtin').keymaps, 'Search keybindings')
  map('n', '<leader>sw', require('telescope.builtin').live_grep, 'Search words')
  map('n', '<leader>sf', require('telescope.builtin').find_files, 'Search files')
  map('n', '<leader>s/', require('telescope.builtin').current_buffer_fuzzy_find, 'Search for words in current buffer')
  if is_available 'nvim-notify' then
    map('n', '<leader>sn', function()
      require('telescope').extensions.notify.notify()
    end, 'Search notifications')
  end

  if is_available 'scratch.nvim' then
    map('n', '<leader>st', function()
      vim.cmd 'ScratchOpen'
    end, 'Search temp files')
  end

  -- map.n["<leader>s'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
  -- map.n["<leader>sh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
  -- map.n["<leader>sm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
  -- map.n["<leader>st"] =
  --   { function() require("telescope.builtin").colorscheme { enable_preview = true } end, desc = "Find themes" }

  -- Git related maps
  map('n', '<leader>gb', function()
    require('telescope.builtin').git_branches { use_file_path = true }
  end, 'Git branches')
  -- map.n['<leader>gc'] = {
  --   function()
  --     require('telescope.builtin').git_commits { use_file_path = true }
  --   end,
  --   desc = 'Git commits (repository)',
  -- }
  -- map.n['<leader>gC'] = {
  --   function()
  --     require('telescope.builtin').git_bcommits { use_file_path = true }
  --   end,
  --   desc = 'Git commits (current file)',
  -- }
  -- map.n['<leader>gt'] = {
  --   function()
  --     require('telescope.builtin').git_status { use_file_path = true }
  --   end,
  --   desc = 'Git status',
  -- }
  -- map.n['<leader>l'] = sections.l
  -- map.n['<leader>ls'] = {
  --   function()
  --     local aerial_avail, _ = pcall(require, 'aerial')
  --     if aerial_avail then
  --       require('telescope').extensions.aerial.aerial()
  --     else
  --       require('telescope.builtin').lsp_document_symbols()
  --     end
  --   end,
  --   desc = 'Search symbols',
  -- }
end
