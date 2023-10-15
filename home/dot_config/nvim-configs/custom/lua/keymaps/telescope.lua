local map = require('utils').map
local is_available = require('utils').is_available

if is_available 'telescope.nvim' then
  map('n', '<leader>sk', require('telescope.builtin').keymaps, 'Search keybindings')
  map('n', '<leader>sw', require('telescope.builtin').live_grep, 'Find words')
  -- map('n', "<leader>sW",
  --   function()
  --     require("telescope.builtin").live_grep {
  --       additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
  --     }
  --   end,
  --   "Find words in all files",
  -- )
  map('n', '<leader>sf', require('telescope.builtin').find_files, 'Find files')
  -- map('n', "<leader>sF",
  --   function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
  --   "Find in all files",
  -- )
  -- map.n["<leader>s<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
  -- map.n["<leader>s'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
  -- map.n["<leader>s/"] =
  --   { function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Find words in current buffer" }
  -- map.n["<leader>sa"] = {
  --   function()
  --     local cwd = vim.fn.stdpath "config" .. "/.."
  --     local search_dirs = {}
  --     for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
  --       if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
  --       if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
  --     end
  --     if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
  --       utils.notify("No user configuration files found", vim.log.levels.WARN)
  --     else
  --       if #search_dirs == 1 then cwd = search_dirs[1] end -- if only one directory, focus cwd
  --       require("telescope.builtin").find_files {
  --         prompt_title = "Config Files",
  --         search_dirs = search_dirs,
  --         cwd = cwd,
  --         follow = true,
  --       } -- call telescope
  --     end
  --   end,
  --   desc = "Find AstroNvim config files",
  -- }
  -- map.n["<leader>sb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
  -- map.n['<leader>sc'] = {
  --   function()
  --     require('telescope.builtin').grep_string()
  --   end,
  --   desc = 'Find word under cursor',
  -- }
  -- map.n['<leader>sC'] = {
  --   function()
  --     require('telescope.builtin').commands()
  --   end,
  --   desc = 'Find commands',
  -- }
  -- map.n["<leader>sh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
  -- map.n["<leader>fk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
  -- map.n["<leader>sm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
  if is_available 'nvim-notify' then
    map('n', '<leader>sn',
      function()
        require('telescope').extensions.notify.notify()
      end,
      'Find notifications'
    )
  end
  -- map.n["<leader>so"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
  -- map.n["<leader>sr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
  -- map.n["<leader>st"] =
  --   { function() require("telescope.builtin").colorscheme { enable_preview = true } end, desc = "Find themes" }

  -- Git related maps
  map('n', '<leader>g', 'Git')
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
