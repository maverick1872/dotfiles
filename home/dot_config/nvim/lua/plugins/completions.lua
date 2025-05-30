local has_words_before = function()
  if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt' then
    return false
  end
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  -- TODO: possible additions would be:
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
    'zbirenbaum/copilot.lua', -- OSS Copilot rewrite in Lua
    'zbirenbaum/copilot-cmp', -- Copilot CMP source
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local notify = require('utils').notify
    notify('System Node Path env var: ' .. os.getenv('SYSTEM_NODE_PATH'), 'debug')
    require('luasnip/loaders/from_vscode').lazy_load()
    require('copilot').setup({
      copilot_node_command = os.getenv('SYSTEM_NODE_PATH'),
    })
    require('copilot_cmp').setup()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept explictly selected item.
        ['<Space>'] = cmp.mapping.confirm({ select = false }), -- Accept explictly selected item.
        -- ['<Esc>'] = cmp.mapping.abort(), -- Close completions and restore line
        ['<Left>'] = cmp.mapping.close(), -- Close completions and restore line
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<Right>'] = cmp.mapping.confirm({ select = false }), -- Accept explictly selected item.
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
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
          if cmp.visible() and has_words_before() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, vim_item)
          -- TODO: potentially lift out to a standalone settings file
          -- vim_item.kind = string.format('%s', icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = '',
            luasnip = '',
            buffer = '',
            path = '',
            copilot = '',
          })[entry.source.name]

          return vim_item
        end,
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        -- { name = 'buffer' },
        { name = 'path' },
        { name = 'copilot' },
      },
      experimental = {
        ghost_text = true,
      },
    })

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
}
