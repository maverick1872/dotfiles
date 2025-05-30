return {
  'mfussenegger/nvim-dap',
  cmd = { 'DapNew' },
  dependencies = {

    -- Creates a beautiful debugger UI
    'igorlfs/nvim-dap-view',
    -- TODO: cleanup in favor of nvim-dap-view
    -- 'rcarriga/nvim-dap-ui',
    -- 'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  -- The following leveraged as a source of reference on how to get an intial working configuration
  -- https://github.com/ecosse3/nvim/blob/dev/lua/plugins/dap.lua
  config = function()
    local dap = require('dap')
    -- local dapui = require('dapui')
    require('mason').setup()

    require('mason-nvim-dap').setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      ensure_installed = { 'js' },
    })

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ DAP UI Setup                                             │
    -- │ For more information, see :help nvim-dap-ui              │
    -- ╰──────────────────────────────────────────────────────────╯
    -- TODO: cleanup in favor of nvim-dap-view
    -- local dap-view = require('dap-view')
    require('dap-view').setup()
    -- dapui.setup({
    --   icons = { expanded = '▾', collapsed = '▸' },
    --   mappings = {
    --     -- Use a table to apply multiple mappings
    --     expand = { '<CR>', '<2-LeftMouse>' },
    --     open = 'o',
    --     remove = 'd',
    --     edit = 'e',
    --     repl = 'r',
    --     toggle = 't',
    --   },
    --   -- Expand lines larger than the window
    --   -- Requires >= 0.7
    --   expand_lines = vim.fn.has('nvim-0.7'),
    --   -- Layouts define sections of the screen to place windows.
    --   -- The position can be "left", "right", "top" or "bottom".
    --   -- The size specifies the height/width depending on position. It can be an Int
    --   -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    --   -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    --   -- Elements are the elements shown in the layout (in order).
    --   -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    --   layouts = {
    --     {
    --       elements = {
    --         { id = 'scopes', size = 0.25 },
    --         { id = 'breakpoints', size = 0.25 },
    --       },
    --       size = 50, -- 50 columns
    --       position = 'left',
    --     },
    --     {
    --       elements = {
    --         'watches',
    --         'repl',
    --       },
    --       size = 0.25, -- 25% of total lines
    --       position = 'bottom',
    --     },
    --   },
    --   floating = {
    --     max_height = nil, -- These can be integers or a float between 0 and 1.
    --     max_width = nil, -- Floats will be treated as percentage of your screen.
    --     border = 'rounded', -- Border style. Can be "single", "double" or "rounded"
    --     mappings = {
    --       close = { 'q', '<Esc>' },
    --     },
    --   },
    --   windows = { indent = 1 },
    --   render = {
    --     max_type_length = nil, -- Can be integer or nil.
    --   },
    -- })
    --
    vim.fn.sign_define('DapBreakpoint', { text = '🔵', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '🔴', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapConditionalBreakpoint', { text = '🟡', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '🟢', texthl = '', linehl = '', numhl = '' })
    -- TODO: cleanup in favor of nvim-dap-view
    -- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Adapters                                                 │
    -- ╰──────────────────────────────────────────────────────────╯
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
          '${port}',
        },
      },
    }

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Configurations                                           │
    -- │ Not necessary at the moment due to default loading of    │
    -- │ configurations defined in .vscode/launch.json            │
    -- ╰──────────────────────────────────────────────────────────╯
    -- exts = { 'javascript', 'typescript' }
    -- for i, ext in ipairs(exts) do
    --   dap.configurations[ext] = {
    --     {
    --       name = 'Attach Node Process (pwa-node)',
    --       type = 'pwa-node',
    --       request = 'attach',
    --       port = 9229,
    --       skipFiles = { '<node_internals>/**', 'node_modules/**' },
    --       cwd = '${workspaceFolder}',
    --     },
    --     {
    --       type = 'pwa-node',
    --       request = 'launch',
    --       name = 'Launch Current File (pwa-node with ts-node)',
    --       cwd = vim.fn.getcwd(),
    --       runtimeArgs = { '--loader', 'ts-node/esm' },
    --       runtimeExecutable = 'node',
    --       args = { '${file}' },
    --       sourceMaps = true,
    --       protocol = 'inspector',
    --       skipFiles = { '<node_internals>/**', 'node_modules/**' },
    --       resolveSourceMapLocations = {
    --         '${workspaceFolder}/**',
    --         '!**/node_modules/**',
    --       },
    --     },
    --     {
    --       type = 'pwa-node',
    --       request = 'launch',
    --       name = 'Launch Test Current File (pwa-node with jest)',
    --       cwd = vim.fn.getcwd(),
    --       runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
    --       runtimeExecutable = 'node',
    --       args = { '${file}', '--coverage', 'false' },
    --       rootPath = '${workspaceFolder}',
    --       sourceMaps = true,
    --       console = 'integratedTerminal',
    --       internalConsoleOptions = 'neverOpen',
    --       skipFiles = { '<node_internals>/**', 'node_modules/**' },
    --     },
    --   }
    -- end
  end,
}
