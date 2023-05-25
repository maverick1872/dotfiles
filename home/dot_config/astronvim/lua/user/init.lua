return {
  lsp = {
    setup_handlers = {
      tsserver = function(_, opts) require("typescript").setup { server = opts } end
    }
  },
  plugins = {
    {
      "almo7aya/openingh.nvim",
      lazy = false
    },
    -- Configure folke/which-key.nvim to include custom commands for Jester plugin
    "jose-elias-alvarez/typescript.nvim", -- add lsp plugin
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "tsserver" }, -- automatically install lsp
      },
    },
    {
      "jay-babu/mason-null-ls.nvim",
      opts = {
        handlers = {
          -- for prettierd
          prettierd = function()
            require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with {
              condition = function(utils)
                return utils.root_has_file "package.json"
                  or utils.root_has_file ".prettierrc*"
              end,
              filetypes = { "html", "json", "javascript", "typescript" }
            })
          end,
          -- For eslint_d:
          eslint_d = function()
            require("null-ls").register(require("null-ls").builtins.diagnostics.eslint_d.with {
              condition = function(utils)
                return utils.root_has_file "package.json"
                  or utils.root_has_file ".eslintrc*"
              end,
            })
          end,
        },
      },
    },
    {
      'David-Kunz/jester', -- enables running jest tests from within nvim 
      opts = {
        path_to_jest_run = 'npx jest',
      }
    },
    {
      'nvim-treesitter/nvim-treesitter', -- Add treesitter lazy configuration to include treesitter playground 
      dependencies = {
        'nvim-treesitter/playground'
      },
      config = function() 
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "javascript", "typescript" },
          highlight = { enable = true },
          playground = { enable = true },
        }
      end,
    },
  },
}
