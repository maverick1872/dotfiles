return {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    -- {
    --   ["n"] = { "NORMAL", "normal" },
    --   ["no"] = { "OP", "normal" },
    --   ["nov"] = { "OP", "normal" },
    --   ["noV"] = { "OP", "normal" },
    --   ["no"] = { "OP", "normal" },
    --   ["niI"] = { "NORMAL", "normal" },
    --   ["niR"] = { "NORMAL", "normal" },
    --   ["niV"] = { "NORMAL", "normal" },
    --   ["i"] = { "INSERT", "insert" },
    --   ["ic"] = { "INSERT", "insert" },
    --   ["ix"] = { "INSERT", "insert" },
    --   ["t"] = { "TERM", "terminal" },
    --   ["nt"] = { "TERM", "terminal" },
    --   ["v"] = { "VISUAL", "visual" },
    --   ["vs"] = { "VISUAL", "visual" },
    --   ["V"] = { "LINES", "visual" },
    --   ["Vs"] = { "LINES", "visual" },
    --   [""] = { "BLOCK", "visual" },
    --   ["s"] = { "BLOCK", "visual" },
    --   ["R"] = { "REPLACE", "replace" },
    --   ["Rc"] = { "REPLACE", "replace" },
    --   ["Rx"] = { "REPLACE", "replace" },
    --   ["Rv"] = { "V-REPLACE", "replace" },
    --   ["s"] = { "SELECT", "visual" },
    --   ["S"] = { "SELECT", "visual" },
    --   [""] = { "BLOCK", "visual" },
    --   ["c"] = { "COMMAND", "command" },
    --   ["cv"] = { "COMMAND", "command" },
    --   ["ce"] = { "COMMAND", "command" },
    --   ["r"] = { "PROMPT", "inactive" },
    --   ["rm"] = { "MORE", "inactive" },
    --   ["r?"] = { "CONFIRM", "inactive" },
    --   ["!"] = { "SHELL", "inactive" },
    --   ["null"] = { "null", "inactive" },
    -- }
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = 'N',
      no = 'N?',
      nov = 'N?',
      noV = 'N?',
      ['no\22'] = 'N?',
      niI = 'Ni',
      niR = 'Nr',
      niV = 'Nv',
      nt = 'Nt',
      v = 'V',
      vs = 'Vs',
      V = 'V_',
      Vs = 'Vs',
      ['\22'] = '^V',
      ['\22s'] = '^V',
      s = 'S',
      S = 'S_',
      ['\19'] = '^S',
      i = 'I',
      ic = 'Ic',
      ix = 'Ix',
      R = 'R',
      Rc = 'Rc',
      Rx = 'Rx',
      Rv = 'Rv',
      Rvc = 'Rv',
      Rvx = 'Rv',
      c = 'C',
      cv = 'Ex',
      r = '...',
      rm = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      t = 'T',
    },
    mode_colors = {
      n = 'red',
      i = 'green',
      v = 'cyan',
      V = 'cyan',
      ['\22'] = 'cyan',
      c = 'orange',
      s = 'purple',
      S = 'purple',
      ['\19'] = 'purple',
      R = 'orange',
      r = 'orange',
      ['!'] = 'red',
      t = 'red',
    },
  },
  -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    return ' %2(' .. self.mode_names[self.mode] .. '%)'
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = self.mode_colors[mode], bold = true }
  end,
  -- Re-evaluate the component only on ModeChanged event!
  -- Also allows the statusline to be re-evaluated when entering operator-pending mode
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function()
      vim.cmd('redrawstatus')
    end),
  },
}
