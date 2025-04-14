return {
  'stevearc/conform.nvim',
  enabled = false,
  event = 'VeryLazy',
  dependencies = {},
  opts = {
    formatters_by_ft = {
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      -- jinja = { "djlint" },
      lua = { "stylua" },
      sh = { "beautysh" },
      terraform = { "terraform_fmt" },
      hcl = { "terraform_fmt" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      yaml = { "yamllint" },
    },
    -- format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_format = "fallback",
    -- },
  },
}
