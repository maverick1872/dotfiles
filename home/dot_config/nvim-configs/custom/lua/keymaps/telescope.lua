local map = require('utils').map
local is_available = require('utils').is_available

if is_available 'telescope.nvim' then
  map('n', '<leader>sk', require('telescope.builtin').keymaps, 'Search keybindings')
  map('n', '<leader>sw', require('telescope.builtin').live_grep, 'Find words')
  map('n', '<leader>sf', require('telescope.builtin').find_files, 'Find files')
  map('n', '<leader>s<CR>', require('telescope.builtin').resume, 'Resume previous search')
  -- map.n["<leader>s'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
  -- map.n["<leader>s/"] =
  --   { function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Find words in current buffer" }
  -- map.n["<leader>sh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
  -- map.n["<leader>sm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
  -- if is_available 'nvim-notify' then
  --   map('n', '<leader>sn', function()
  --     require('telescope').extensions.notify.notify()
  --   end, 'Find notifications')
  -- end
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
