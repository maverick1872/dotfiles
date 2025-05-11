return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  dependencies = {},
  opts = {
    -- Event to trigger linters
    -- TODO convert this to self managed user commands and auto commands
    events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },

    -- Linters by filetype
    linters_by_ft = {
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      javascriptreact = { 'eslint' },
      typescriptreact = { 'eslint' },
      python = { 'flake8', 'mypy' },
      lua = { 'luacheck' },
      sh = { 'shellcheck' },
      markdown = { 'markdownlint' },
      yaml = { 'yamllint' },
      json = { 'jsonlint' },
      dockerfile = { 'hadolint' },
      terraform = { 'tflint' },
    },

    -- Linter configurations
    linters = {
      -- Example of configuring a linter
      eslint = {
        -- Only use eslint if an .eslintrc.* file exists in the project
        condition = function(ctx)
          return vim.fs.find({ '.eslintrc', '.eslintrc.js', '.eslintrc.json', '.eslintrc.yml' }, {
            path = ctx.filename,
            upward = true,
          })[1] ~= nil
        end,
      },

      luacheck = {
        -- Adjust luacheck options
        args = {
          '--globals',
          'vim',
          '--no-max-line-length',
        },
      },
    },
  },
  config = function(_, opts)
    local lint = require('lint')

    -- Setup linters from opts
    lint.linters_by_ft = opts.linters_by_ft

    -- Configure linters
    for name, linter_opts in pairs(opts.linters or {}) do
      if lint.linters[name] then
        lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter_opts)
      end
    end

    -- Create autocmd to trigger linting
    local lint_augroup = vim.api.nvim_create_augroup('nvim-lint', { clear = true })
    vim.api.nvim_create_autocmd(opts.events, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })

    -- Command to manually trigger linting
    vim.api.nvim_create_user_command('Lint', function()
      require('lint').try_lint()
    end, {})
  end,
}
