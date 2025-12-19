return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  dependencies = {},
  opts = {
    format_on_save = false, -- Formatting is triggered by the `FormatBuffer` command
    formatters_by_ft = {
      css = { 'biome', 'prettier' },
      html = { 'biome', 'prettier' },
      json = { 'biome', 'prettier' },
      javascript = { 'biome', 'prettier' },
      javascriptreact = { 'biome', 'prettier' },
      jinja = { 'djlint' },
      lua = { 'stylua', 'trim_whitespace' },
      sh = { 'beautysh' },
      terraform = { 'terraform_fmt' },
      hcl = { 'terraform_fmt' },
      typescript = { 'biome', 'prettier' },
      typescriptreact = { 'biome', 'prettier' },
      yaml = { 'yamlfmt' },
    },
    formatters = {
      beautysh = {
        prepend_args = { '--indent-size', '2' },
      },
      yamlfmt = {
        prepend_args = {
          '-formatter',
          'retain_line_breaks_single=true,trim_trailing_whitespace=true,pad_line_comments=2',
        },
      },
    },
  },
}
