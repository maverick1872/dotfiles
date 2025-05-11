local map = require('utils').map
local is_available = require('utils').is_available
-- local get_icon = require('utils').get_icon
-- local section = { desc = get_icon('Debugger', 1, true) .. 'Debugger' }

if is_available('nvim-dap') then
  map('n', '<leader>dn', function()
    vim.cmd('DapNew')
  end, 'New Session')
  map('n', '<leader>ds', require('dap').continue, 'Start/Continue')
  map('n', '<leader>dc', require('dap').run_to_cursor, 'Run To Cursor')
  map('n', '<leader>db', require('dap').toggle_breakpoint, 'Toggle Breakpoint')
  map('n', '<leader>dB', function()
    vim.ui.input({ prompt = 'Condition: ' }, function(condition)
      if condition then
        require('dap').set_breakpoint(condition)
      end
    end)
  end, 'Conditional Breakpoint')
  map('n', '<leader>di', require('dap').step_into, 'Step Into')
  map('n', '<leader>do', require('dap').step_over, 'Step Over')
  map('n', '<leader>dO', require('dap').step_out, 'Step Out')
  map('n', '<leader>dq', require('dap').close, 'Close Session')
  map('n', '<leader>dQ', require('dap').terminate, 'Terminate Session')
  map('n', '<leader>dp', require('dap').pause, 'Pause')
  map('n', '<leader>dR', require('dap').restart_frame, 'Restart')

  if is_available('nvim-dap-ui') then
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
