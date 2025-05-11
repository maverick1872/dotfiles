return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  dependencies = {},
  opts = {
    formatters_by_ft = {
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      jinja = { 'djlint' },
      lua = { 'stylua' },
      sh = { 'beautysh' },
      terraform = { 'terraform_fmt' },
      hcl = { 'terraform_fmt' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      yaml = { 'yamllint' },
    },
    format_on_save = false, -- Formatting is triggered by the `FormatBuffer` command
  },
  formatters = {
    beautysh = {
      prepend_args = { '--indent-size', '2' },
    },
    stylelua = {},
  },
}
