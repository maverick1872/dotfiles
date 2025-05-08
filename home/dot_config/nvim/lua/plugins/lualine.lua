-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

local colors = {
  blue = '#80a0ff',
  cyan = '#79dac8',
  black = '#080808',
  white = '#c6c6c6',
  red = '#ff5189',
  -- violet = '#4f3257',
  violet = '#d183e8',
  dark_violet = '#4f3257',
  grey = '#303030',
  ltgrey = '#505050',
  -- astrodark = '#1b1f27',
  -- astrodark = nil,
  astrodark = '#121317',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.astrodark },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.astrodark },
    b = { fg = colors.white, bg = colors.astrodark },
    c = { fg = colors.black, bg = colors.astrodark },
  },
}

local lsp = {
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and client.name ~= 'null-ls' and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSPs:',
  color = { fg = colors.ltgrey, gui = 'bold' },
}

return {
  'nvim-lualine/lualine.nvim',
  priority = 500,
  opts = {
    options = {
      theme = bubbles_theme,
      component_separators = '|',
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        'dashboard',
        tabline = {},
        statusline = {
          -- 'dap-repl',
          -- 'dapui_breakpoints',
          -- 'dapui_console',
          -- 'dapui_scopes',
          -- 'dapui_watches',
          -- 'dapui_stacks',
        },
        winbar = {
          'dap-repl',
          'dapui_breakpoints',
          'dapui_console',
          'dapui_scopes',
          'dapui_watches',
          'dapui_stacks',
        },
      },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          separator = { left = '' },
          right_padding = 2,
        },
      },
      lualine_b = {
        {
          'filename',
          path = 1,
          on_click = function()
            local path = vim.fn.expand '%:.'
            vim.fn.setreg('+', path)
            vim.notify('Copied path: ' .. path)
          end,
        },
        {
          function()
            local has_formatter = false
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            for _, client in ipairs(clients) do
              if client.server_capabilities.documentFormattingProvider then
                has_formatter = true
                break
              end
            end
            local formatting_disabled = (vim.b.disable_autoformat or vim.g.disable_autoformat)
            return has_formatter and
                (formatting_disabled and "Auto format ✗" or "Auto format ✓") or ""
          end,
          color = { fg = colors.green },
        },
        {
          function()
            local in_presentation_mode = vim.g.presentation_mode or vim.b.presentation_mode
            return vim.g.presentation_mode and "󱡊 PRESENTATION" or ""
          end,
          color = { fg = colors.red, gui = 'bold' },
        },
      },
      lualine_c = { '%=', lsp },
      lualine_x = {
      },
      lualine_y = {
        'diff',
        {
          'branch',
          on_click = function()
            local branch = vim.fn.system "git branch --show-current 2> /dev/null | tr -d '\n'"
            local trimmedBranch = branch:gsub('\n', '')
            vim.fn.setreg('+', trimmedBranch)
            vim.notify('Copied branch: ' .. trimmedBranch)
          end,
        },
        'filetype',
      },
      lualine_z = {
        {
          'os.date("%I:%M", os.time())',
          separator = { right = '' },
          left_padding = 2,
        },
      },
    },
    inactive_sections = {
      lualine_a = {
        {
          'filename',
          path = 1,
          on_click = function()
            local path = vim.fn.expand '%:.'
            vim.fn.setreg('+', path)
            vim.notify('Copied path: ' .. path)
          end,
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {
      lualine_a = {
        {
          'buffers',
          show_filename_only = true,
          show_modified_status = true,
          buffers_color = {
            active = { fg = colors.white, bg = colors.dark_violet, gui = 'bold' },
            inactive = { fg = colors.white, bg = colors.astrodark, gui = 'bold' },
          },
          separator = { left = '', right = '' },
          right_padding = 2,
          symbols = { alternate_file = '' },
        },
      },
    },
    inactive_winbar = {
      lualine_a = {
        {
          'buffers',
          show_filename_only = true,
          show_modified_status = true,
          buffers_color = {
            active = { fg = colors.ltgrey, bg = colors.astrodark },
            inactive = { fg = colors.ltgrey, bg = colors.astrodark },
          },
          separator = { left = '', right = '' },
          right_padding = 2,
          symbols = { alternate_file = '' },
        },
      },
    },
    tabline = {
      -- lualine_a = {
      --   {
      --     'tabs',
      --     color = { fg = colors.white, bg = colors.astrodark },
      --     cond = function()
      --       return #vim.fn.gettabinfo() > 1
      --     end,
      --     separator = { left = '', right = '' },
      --     right_padding = 2,
      --     -- symbols = { alternate_file = '' },
      --   },
      -- },
    },
    extensions = {},
  },
}
