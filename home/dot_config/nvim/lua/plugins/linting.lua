local notify = require('utils').notify

return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  dependencies = {},
  opts = {
    -- Event to trigger linters
    events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },

    -- Linters by filetype
    linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      python = { 'flake8', 'mypy' },
      lua = { 'luacheck' },
      sh = { 'shellcheck' },
      markdown = { 'markdownlint' },
      yaml = { 'yamllint' },
      json = { 'jsonlint' },
      dockerfile = { 'hadolint' },
      terraform = { 'tflint' },
    },

    linter_overrides = {
      luacheck = {
        condition = function(ctx)
          if ctx.filename == '.luacheckrc' then
            return false
          end
        end,
      },
    },
  },
  config = function(_, opts)
    local lint = require('lint')

    -- Setup linters from opts
    lint.linters_by_ft = opts.linters_by_ft

    -- Configure linter option overrides if any
    for name, overrides in pairs(opts.linter_overrides or {}) do
      if lint.linters[name] then
        lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], overrides)
      end
    end

    -- User Command to manually trigger linting
    vim.api.nvim_create_user_command('Lint', function()
      local nvim_lint = require('lint')
      local linters_for_filetype = nvim_lint.linters_by_ft[vim.bo.filetype] or {}
      local file = vim.api.nvim_buf_get_name(0)
      local ctx = {
        filename = vim.fs.basename(file),
        dirname = vim.fn.fnamemodify(file, ':h'),
      }

      linters_for_filetype = vim.tbl_filter(function(name)
        local linter_configuration = nvim_lint.linters[name]
        return linter_configuration
          and not (
            type(linter_configuration) == 'table'
            and linter_configuration.condition
            and not linter_configuration.condition(ctx)
          )
      end, linters_for_filetype)

      if #linters_for_filetype > 0 then
        nvim_lint.try_lint(linters_for_filetype)
      end
    end, {})

    -- Create autocmd to trigger linting
    local lint_augroup = vim.api.nvim_create_augroup('nvim-lint', { clear = true })
    vim.api.nvim_create_autocmd(opts.events, {
      group = lint_augroup,
      callback = function()
        vim.cmd('Lint')
      end,
    })
  end,
}
