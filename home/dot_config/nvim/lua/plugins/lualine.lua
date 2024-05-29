-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

local colors = {
  blue = '#80a0ff',
  cyan = '#79dac8',
  black = '#080808',
  white = '#c6c6c6',
  red = '#ff5189',
  violet = '#d183e8',
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
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
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
      },
      lualine_c = { '%=', lsp },
      lualine_x = {},
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
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  },
}
