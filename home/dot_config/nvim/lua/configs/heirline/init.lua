local M = {}
local conditions = require 'utils.conditions'
local utils = require 'utils'

local WorkDir = {
    provider = function()
        local icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ":~")
        if not conditions.width_percent_below(#cwd, 0.25) then
            cwd = vim.fn.pathshorten(cwd)
        end
        local trail = cwd:sub(-1) == '/' and '' or "/"
        return icon .. cwd  .. trail
    end,
    hl = { fg = "blue", bold = true },
}

local colors = {
    bright_bg = utils.get_highlight("Folded").bg,
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("diffDeleted").fg,
    git_add = utils.get_highlight("diffAdded").fg,
    git_change = utils.get_highlight("diffChanged").fg,
}

function M.Opts()
    local status = require 'utils.status'
    return {
      opts = {
        disable_winbar_cb = function(args)
          return not require('utils.buffer').is_valid(args.buf)
            or status.condition.buffer_matches({
              buftype = { 'terminal', 'prompt', 'nofile', 'help', 'quickfix' },
              filetype = { 'NvimTree', 'neo%-tree', 'dashboard', 'Outline', 'aerial' },
            }, args.buf)
        end,
      },
      colors = colors,
      statusline = M.StatusLine,
      -- winbar = require('configs.heirline').WinBar,
      -- tabline = require('configs.heirline').TabLine,
      -- statuscolumn = require('configs.heirline').StatusColumn,
    }
end

M.StatusLine = {
  hl = { fg = 'fg', bg = 'bg' },
  WorkDir,
  require('configs.heirline.file').FileComponent
  -- status.component.mode(),
  -- status.component.git_branch(),
  -- status.component.file_info { filetype = {}, filename = false, file_modified = false },
  -- status.component.git_diff(),
  -- status.component.diagnostics(),
  -- status.component.fill(),
  -- status.component.cmd_info(),
  -- status.component.fill(),
  -- status.component.lsp(),
  -- status.component.treesitter(),
  -- status.component.nav(),
  -- status.component.mode { surround = { separator = 'right' } },
}

--[[ M.WinBar = {
  init = function(self)
    self.bufnr = vim.api.nvim_get_current_buf()
  end,
  fallthrough = false,
  {
    condition = function()
      return not status.condition.is_active()
    end,
    status.component.separated_path(),
    status.component.file_info {
      file_icon = { hl = status.hl.file_icon 'winbar', padding = { left = 0 } },
      file_modified = false,
      file_read_only = false,
      hl = status.hl.get_attributes('winbarnc', true),
      surround = false,
      update = 'BufEnter',
    },
  },
  status.component.breadcrumbs { hl = status.hl.get_attributes('winbar', true) },
} ]]

--[[ M.TabLine = {
  { -- file tree padding
    condition = function(self)
      self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
      return status.condition.buffer_matches({
        filetype = {
          'NvimTree',
          'OverseerList',
          'aerial',
          'dap-repl',
          'dapui_.',
          'edgy',
          'neo%-tree',
          'undotree',
        },
      }, vim.api.nvim_win_get_buf(self.winid))
    end,
    provider = function(self)
      return string.rep(' ', vim.api.nvim_win_get_width(self.winid) + 1)
    end,
    hl = { bg = 'tabline_bg' },
  },
  status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
  status.component.fill { hl = { bg = 'tabline_bg' } }, -- fill the rest of the tabline with background color
  { -- tab list
    condition = function()
      return #vim.api.nvim_list_tabpages() >= 2
    end, -- only show tabs if there are more than one
    status.heirline.make_tablist { -- component for each tab
      provider = status.provider.tabnr(),
      hl = function(self)
        return status.hl.get_attributes(status.heirline.tab_type(self, 'tab'), true)
      end,
    },
    { -- close button for current tab
      provider = status.provider.close_button { kind = 'TabClose', padding = { left = 1, right = 1 } },
      hl = status.hl.get_attributes('tab_close', true),
      on_click = {
        callback = function()
          require('utils.buffer').close_tab()
        end,
        name = 'heirline_tabline_close_tab_callback',
      },
    },
  },
} ]]

--[[ M.StatusColumn = vim.fn.has 'nvim-0.9' == 1 and {
  status.component.foldcolumn(),
  status.component.fill(),
  status.component.numbercolumn(),
  status.component.signcolumn(),
} or nil ]]

return M
