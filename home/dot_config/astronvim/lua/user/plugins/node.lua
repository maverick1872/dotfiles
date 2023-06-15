return {
  -- Configure folke/which-key.nvim to include custom commands for Jester plugin
  {
    'David-Kunz/jester', -- enables running jest tests from within nvim 
    ft = {'typescript', 'javascript'},
    opts = {
      path_to_jest_run = 'npx jest',
    }
  },
}
