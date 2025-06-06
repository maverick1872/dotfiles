local M = {}

function M.map(mode, lhs, rhs, desc, opts)
  local options = { noremap = true, silent = true }
  if desc then
    options = vim.tbl_extend('force', options, { desc = desc })
  end
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

--- Serve a notification with a title predefined title
---@param msg string|table The notification body
---@param level? string|number The type of the notification (:help vim.log.levels)
---@param opts? table The nvim-notify options to use (:help notify.Options)
function M.notify(msg, level, opts)
  if type(msg) == 'table' then
    msg = 'Table Contents: \n' .. M.stringify_table(msg)
  end

  vim.schedule(function()
    if M.is_available('nvim-notify') then
      require('notify').notify(msg, level, M.extend_tbl({ title = 'Neovim' }, opts))
    else
      vim.notify(msg, level, M.extend_tbl({ title = 'Neovim' }, opts))
    end
  end)
end

function M.stringify_table(tbl, indentLevel)
  local str = ''
  local indentStr = '#'

  if indentLevel == nil then
    return M.stringify_table(tbl, 0)
  end

  for _ = 0, indentLevel do
    indentStr = indentStr .. '\t'
  end

  for index, value in pairs(tbl) do
    if type(value) == 'table' then
      str = str .. indentStr .. index .. ': \n' .. M.stringify_table(value, (indentLevel + 1))
    else
      str = str .. indentStr .. index .. ': ' .. value .. '\n'
    end
  end
  return str
end

--- Run a shell command and capture the output and if the command succeeded or failed
---@param cmd string|string[] The terminal command to execute
---@param show_error? boolean Whether or not to show an unsuccessful command as an error to the user
---@return string|nil # The result of a successfully executed command or nil
function M.cmd(cmd, show_error)
  if type(cmd) == 'string' then
    cmd = { cmd }
  end
  if vim.fn.has('win32') == 1 then
    cmd = vim.list_extend({ 'cmd.exe', '/C' }, cmd)
  end
  local result = vim.fn.system(cmd)
  local success = vim.api.nvim_get_vvar('shell_error') == 0
  if not success and (show_error == nil or show_error) then
    vim.api.nvim_echo(
      { { 'Error running command ' .. table.concat(cmd, ' ') .. '\nError message:\n' .. result } },
      true,
      { err = true }
    )
  end
  return success and result:gsub('[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]', '') or nil
end

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend('force', default, opts) or opts
end

function M.get_highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

--- Call function if a condition is met
---@param func function The function to run
---@param condition boolean # Whether to run the function or not
---@return any|nil result # the result of the function running or nil
function M.conditional_func(func, condition, ...)
  -- if the condition is true or no condition is provided, evaluate the function with the rest of the parameters and return the result
  if condition and type(func) == 'function' then
    return func(...)
  end
end

-- --- Partially reload AstroNvim user settings. Includes core vim options, mappings, and highlights. This is an experimental feature and may lead to instabilities until restart.
-- ---@param quiet? boolean Whether or not to notify on completion of reloading
-- ---@return boolean # True if the reload was successful, False otherwise
-- function M.reload(quiet)
--   local was_modifiable = vim.opt.modifiable:get()
--   if not was_modifiable then
--     vim.opt.modifiable = true
--   end
--   local core_modules = { 'astronvim.bootstrap', 'astronvim.options', 'astronvim.mappings' }
--   local modules = vim.tbl_filter(function(module)
--     return module:find '^user%.'
--   end, vim.tbl_keys(package.loaded))
--
--   vim.tbl_map(require('plenary.reload').reload_module, vim.list_extend(modules, core_modules))
--
--   local success = true
--   for _, module in ipairs(core_modules) do
--     local status_ok, fault = pcall(require, module)
--     if not status_ok then
--       vim.api.nvim_err_writeln('Failed to load ' .. module .. '\n\n' .. fault)
--       success = false
--     end
--   end
--   if not was_modifiable then
--     vim.opt.modifiable = false
--   end
--   if not quiet then -- if not quiet, then notify of result
--     if success then
--       M.notify('Neovim successfully reloaded', vim.log.levels.INFO)
--     else
--       M.notify('Error reloading AstroNvim...', vim.log.levels.ERROR)
--     end
--   end
--   vim.cmd.doautocmd 'ColorScheme'
--   return success
-- end

-- --- Insert one or more values into a list like table and maintain that you do not insert non-unique values (THIS MODIFIES `lst`)
-- ---@param lst any[]|nil The list like table that you want to insert into
-- ---@param vals any|any[] Either a list like table of values to be inserted or a single value to be inserted
-- ---@return any[] # The modified list like table
-- function M.list_insert_unique(lst, vals)
--   if not lst then
--     lst = {}
--   end
--   assert(vim.tbl_islist(lst), 'Provided table is not a list like table')
--   if not vim.tbl_islist(vals) then
--     vals = { vals }
--   end
--   local added = {}
--   vim.tbl_map(function(v)
--     added[v] = true
--   end, lst)
--   for _, val in ipairs(vals) do
--     if not added[val] then
--       table.insert(lst, val)
--       added[val] = true
--     end
--   end
--   return lst
-- end

-- --- Get an icon from the AstroNvim internal icons if it is available and return it
-- ---@param kind string The kind of icon in astronvim.icons to retrieve
-- ---@param padding? integer Padding to add to the end of the icon
-- ---@param no_fallback? boolean Whether or not to disable fallback to text icon
-- ---@return string icon
-- function M.get_icon(kind, padding, no_fallback)
--   if not vim.g.icons_enabled and no_fallback then
--     return ''
--   end
--   local icon_pack = vim.g.icons_enabled and 'icons' or 'text_icons'
--   if not M[icon_pack] then
--     M.icons = astronvim.user_opts('icons', require 'astronvim.icons.nerd_font')
--     M.text_icons = astronvim.user_opts('text_icons', require 'astronvim.icons.text')
--   end
--   local icon = M[icon_pack] and M[icon_pack][kind]
--   return icon and icon .. string.rep(' ', padding or 0) or ''
-- end

-- --- Get a icon spinner table if it is available in the AstroNvim icons. Icons in format `kind1`,`kind2`, `kind3`, ...
-- ---@param kind string The kind of icon to check for sequential entries of
-- ---@return string[]|nil spinners # A collected table of spinning icons in sequential order or nil if none exist
-- function M.get_spinner(kind, ...)
--   local spinner = {}
--   repeat
--     local icon = M.get_icon(('%s%d'):format(kind, #spinner + 1), ...)
--     if icon ~= '' then
--       table.insert(spinner, icon)
--     end
--   until not icon or icon == ''
--   if #spinner > 0 then
--     return spinner
--   end
-- end

-- --- Get highlight properties for a given highlight name
-- ---@param name string The highlight group name
-- ---@param fallback? table The fallback highlight properties
-- ---@return table properties # the highlight group properties
-- function M.get_hlgroup(name, fallback)
--   if vim.fn.hlexists(name) == 1 then
--     local hl
--     if vim.api.nvim_get_hl then -- check for new neovim 0.9 API
--       hl = vim.api.nvim_get_hl(0, { name = name, link = false })
--       if not hl.fg then
--         hl.fg = 'NONE'
--       end
--       if not hl.bg then
--         hl.bg = 'NONE'
--       end
--     else
--       hl = vim.api.nvim_get_hl_by_name(name, vim.o.termguicolors)
--       if not hl.foreground then
--         hl.foreground = 'NONE'
--       end
--       if not hl.background then
--         hl.background = 'NONE'
--       end
--       hl.fg, hl.bg = hl.foreground, hl.background
--       hl.ctermfg, hl.ctermbg = hl.fg, hl.bg
--       hl.sp = hl.special
--     end
--     return hl
--   end
--   return fallback or {}
-- end

-- --- Open a URL under the cursor with the current operating system
-- ---@param path string The path of the file to open with the system opener
-- function M.system_open(path)
--   -- TODO: REMOVE WHEN DROPPING NEOVIM <0.10
--   if vim.ui.open then
--     return vim.ui.open(path)
--   end
--   local cmd
--   if vim.fn.has('win32') == 1 and vim.fn.executable('explorer') == 1 then
--     cmd = { 'cmd.exe', '/K', 'explorer' }
--   elseif vim.fn.has('unix') == 1 and vim.fn.executable('xdg-open') == 1 then
--     cmd = { 'xdg-open' }
--   elseif (vim.fn.has('mac') == 1 or vim.fn.has('unix') == 1) and vim.fn.executable('open') == 1 then
--     cmd = { 'open' }
--   end
--   if not cmd then
--     M.notify('Available system opening tool not found!', vim.log.levels.ERROR)
--   end
--   vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand('<cfile>') }), { detach = true })
-- end

-- --- Toggle a user terminal if it exists, if not then create a new one and save it
-- ---@param opts string|table A terminal command string or a table of options for Terminal:new() (Check toggleterm.nvim documentation for table format)
-- function M.toggle_term_cmd(opts)
--   local terms = astronvim.user_terminals
--   -- if a command string is provided, create a basic table for Terminal:new() options
--   if type(opts) == 'string' then
--     opts = { cmd = opts, hidden = true }
--   end
--   local num = vim.v.count > 0 and vim.v.count or 1
--   -- if terminal doesn't exist yet, create it
--   if not terms[opts.cmd] then
--     terms[opts.cmd] = {}
--   end
--   if not terms[opts.cmd][num] then
--     if not opts.count then
--       opts.count = vim.tbl_count(terms) * 100 + num
--     end
--     if not opts.on_exit then
--       opts.on_exit = function()
--         terms[opts.cmd][num] = nil
--       end
--     end
--     terms[opts.cmd][num] = require('toggleterm.terminal').Terminal:new(opts)
--   end
--   -- toggle the terminal
--   terms[opts.cmd][num]:toggle()
-- end

-- --- Resolve the options table for a given plugin with lazy
-- ---@param plugin string The plugin to search for
-- ---@return table opts # The plugin options
-- function M.plugin_opts(plugin)
--   local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
--   local lazy_plugin_avail, lazy_plugin = pcall(require, 'lazy.core.plugin')
--   local opts = {}
--   if lazy_config_avail and lazy_plugin_avail then
--     local spec = lazy_config.spec.plugins[plugin]
--     if spec then
--       opts = lazy_plugin.values(spec, 'opts')
--     end
--   end
--   return opts
-- end

-- --- A helper function to wrap a module function to require a plugin before running
-- ---@param plugin string The plugin to call `require("lazy").load` with
-- ---@param module table The system module where the functions live (e.g. `vim.ui`)
-- ---@param func_names string|string[] The functions to wrap in the given module (e.g. `{ "ui", "select }`)
-- function M.load_plugin_with_func(plugin, module, func_names)
--   if type(func_names) == 'string' then
--     func_names = { func_names }
--   end
--   for _, func in ipairs(func_names) do
--     local old_func = module[func]
--     module[func] = function(...)
--       module[func] = old_func
--       require('lazy').load({ plugins = { plugin } })
--       module[func](...)
--     end
--   end
-- end

--- Register queued which-key mappings
function M.which_key_register()
  if M.which_key_queue then
    local wk_avail, wk = pcall(require, 'which-key')
    if wk_avail then
      for mode, registration in pairs(M.which_key_queue) do
        wk.register(registration, { mode = mode })
      end
      M.which_key_queue = nil
    end
  end
end

-- --- Get an empty table of mappings with a key for each map mode
-- ---@return table<string,table> # a table with entries for each map mode
-- function M.empty_map_table()
--   local maps = {}
--   for _, mode in ipairs({ '', 'n', 'v', 'x', 's', 'o', '!', 'i', 'l', 'c', 't' }) do
--     maps[mode] = {}
--   end
--   if vim.fn.has('nvim-0.10.0') == 1 then
--     for _, abbr_mode in ipairs({ 'ia', 'ca', '!a' }) do
--       maps[abbr_mode] = {}
--     end
--   end
--   return maps
-- end

-- --- Table based API for setting keybindings
-- ---@param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
-- ---@param base? table A base set of options to set on every keybinding
-- function M.set_mappings(map_table, base)
--   -- iterate over the first keys for each mode
--   base = base or {}
--   for mode, maps in pairs(map_table) do
--     -- iterate over each keybinding set in the current mode
--     for keymap, options in pairs(maps) do
--       -- build the options for the command accordingly
--       if options then
--         local cmd = options
--         local keymap_opts = base
--         if type(options) == 'table' then
--           cmd = options[1]
--           keymap_opts = vim.tbl_deep_extend('force', keymap_opts, options)
--           keymap_opts[1] = nil
--         end
--         if not cmd or keymap_opts.name then -- if which-key mapping, queue it
--           if not keymap_opts.name then
--             keymap_opts.name = keymap_opts.desc
--           end
--           if not M.which_key_queue then
--             M.which_key_queue = {}
--           end
--           if not M.which_key_queue[mode] then
--             M.which_key_queue[mode] = {}
--           end
--           M.which_key_queue[mode][keymap] = keymap_opts
--         else -- if not which-key mapping, set it
--           vim.keymap.set(mode, keymap, cmd, keymap_opts)
--         end
--       end
--     end
--   end
--   if package.loaded['which-key'] then
--     M.which_key_register()
--   end -- if which-key is loaded already, register
-- end

--- regex used for matching a valid URL/URI string
M.url_matcher =
  '\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+'

-- --- Delete the syntax matching rules for URLs/URIs if set
-- function M.delete_url_match()
--   for _, match in ipairs(vim.fn.getmatches()) do
--     if match.group == 'HighlightURL' then
--       vim.fn.matchdelete(match.id)
--     end
--   end
-- end

-- --- Add syntax matching rules for highlighting URLs/URIs
-- function M.set_url_match()
--   M.delete_url_match()
--   if vim.g.highlighturl_enabled then
--     vim.fn.matchadd('HighlightURL', M.url_matcher, 15)
--   end
-- end

return M
