return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function ()
    require('null-ls').setup()
  end,
}
