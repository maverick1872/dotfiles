return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPost',
  cmd = 'TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      rainbow = {
        enable = true,
      },
      ensure_installed = {
        'bash',
        'dockerfile',
        'go',
        'hcl',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'prisma',
        'python',
        'rust',
        'terraform',
        'toml',
        'typescript',
        'vim',
        'yaml',
      },
      autotag = {
        enable = true,
        filetypes = {
          'javascript',
          'typescript',
        },
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}

