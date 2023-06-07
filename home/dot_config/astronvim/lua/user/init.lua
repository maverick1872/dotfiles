return {
  lsp = {
    setup_handlers = {
      tsserver = function(_, opts) require("typescript").setup { server = opts } end
    }
  },
}
