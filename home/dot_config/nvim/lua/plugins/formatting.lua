return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  dependencies = {},
  opts = {
    format_on_save = false, -- Formatting is triggered by the `FormatBuffer` command
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
      yaml = { 'yamlfmt' },
    },
    formatters = {
      beautysh = {
        prepend_args = { '--indent-size', '2' },
      },
      yamlfmt = {
        prepend_args = { '-formatter', 'retain_line_breaks_single=true,trim_trailing_whitespace=true' },
      },
    },
  },
}
