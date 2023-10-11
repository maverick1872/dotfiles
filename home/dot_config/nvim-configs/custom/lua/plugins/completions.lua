return {
  'hrsh7th/nvim-cmp',
  event = 'VeryLazy',
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require("luasnip/loaders/from_vscode").lazy_load()
    --   local has_words_before = function()
    --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
    --   end

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<CR>'] = cmp.mapping.confirm { select = false }, -- Accept explictly selected item.
        ['<Space>'] = cmp.mapping.confirm { select = false }, -- Accept explictly selected item.
        ['<Esc>'] = cmp.mapping.abort(), -- Close completions and restore line
        ['<Left>'] = cmp.mapping.close(), -- Close completions and restore line
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<Right>'] = cmp.mapping.confirm { select = false }, -- Accept explictly selected item.
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            -- elseif check_backspace() then -- Source: lazynvim
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          -- vim_item.kind = string.format('%s', icons[vim_item.kind])
          vim_item.menu = ({
            luasnip = '[snip]',
            buffer = '[nearby]',
            path = '[path]',
          })[entry.source.name]

          return vim_item
        end,
      },
      sources = {
        -- {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        -- c
        -- { name = 'buffer' },
        { name = 'path' },
        -- },
      },
      experimental = {
        ghost_text = true,
      },
    }

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' },
      }, {
        { name = 'buffer' },
      }),
    })

    cmp.setup.cmdline('/', {
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
  -- possible additions would be:
  -- cmp-npm
  -- search nvim-cmp repo for aditional sources
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-git',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
  },
}
