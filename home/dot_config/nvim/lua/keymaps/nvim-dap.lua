local map = require('utils').map
local is_available = require('utils').is_available
local notify = require('utils').notify
-- local get_icon = require('utils').get_icon
-- local section = { desc = get_icon('Debugger', 1, true) .. 'Debugger' }

if is_available('nvim-dap') then
  notify('binding nvim-dap keybinds')
  map({ 'n', 'v' }, '<leader>d', 'Debugger')
  -- modified function keys found with `showkey -a` in the terminal to get key code
  -- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
  map('n', '<F5>', require('dap').continue, 'Debugger: Start')
  map('n', '<F17>', require('dap').terminate, 'Debugger: Stop') -- Shift+F5
  map('n', '<F21>', function()
    vim.ui.input({ prompt = 'Condition: ' }, function(condition)
      if condition then
        require('dap').set_breakpoint(condition)
      end
    end)
  end, 'Debugger: Conditional Breakpoint')
  map('n', '<F29>', require('dap').restart_frame, 'Debugger: Restart') -- Control+F5
  map('n', '<F6>', require('dap').pause, 'Debugger: Pause')
  map('n', '<F9>', require('dap').toggle_breakpoint, 'Debugger: Toggle Breakpoint')
  map('n', '<F10>', require('dap').step_over, 'Debugger: Step Over')
  map('n', '<F11>', require('dap').step_into, 'Debugger: Step Into')
  map('n', '<F23>', require('dap').step_out, 'Debugger: Step Out') -- Shift+F11
  map('n', '<leader>db', require('dap').toggle_breakpoint, 'Toggle Breakpoint (F9)')
  map('n', '<leader>dB', require('dap').clear_breakpoints, 'Clear Breakpoints')
  -- map('n', '<leader>dc', require('dap').continue, 'Start/Continue (F5)')
  map('n', '<leader>dC', function()
    vim.ui.input({ prompt = 'Condition: ' }, function(condition)
      if condition then
        require('dap').set_breakpoint(condition)
      end
    end)
  end, 'Conditional Breakpoint (S-F9)')
  map('n', '<leader>di', require('dap').step_into, 'Step Into (F11)')
  map('n', '<leader>do', require('dap').step_over, 'Step Over (F10)')
  map('n', '<leader>dO', require('dap').step_out, 'Step Out (S-F11)')
  map('n', '<leader>dq', require('dap').close, 'Close Session')
  map('n', '<leader>dQ', require('dap').terminate, 'Terminate Session (S-F5)')
  map('n', '<leader>dp', require('dap').pause, 'Pause (F6)')
  map('n', '<leader>dr', require('dap').restart_frame, 'Restart (C-F5)')
  map('n', '<leader>dR', require('dap').repl.toggle, 'Toggle REPL')
  map('n', '<leader>ds', require('dap').run_to_cursor, 'Run To Cursor')

  if is_available('nvim-dap-ui') then
    notify('binding nvim-dap-ui keybinds')
    map('n', '<leader>dE', function()
      vim.ui.input({ prompt = 'Expression: ' }, function(expr)
        if expr then
          require('dapui').eval(expr, { enter = true })
        end
      end)
    end, 'Evaluate Input')
    map('v', '<leader>dE', require('dapui').eval, 'Evaluate Input')
    map('n', '<leader>du', require('dapui').toggle, 'Toggle Debugger UI')
    map('n', '<leader>dh', require('dap.ui.widgets').hover, 'Debugger Hover')
  end
end
