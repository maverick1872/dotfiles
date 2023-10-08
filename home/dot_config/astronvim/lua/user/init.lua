return {
  lsp = {
    setup_handlers = {
      tsserver = function(_, opts) require("typescript").setup { server = opts } end
    },
    formatting = {
      disabled = {
        "tsserver"
      }
    }
  },
  polish = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      command = "cd $PWD",
    })
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}
