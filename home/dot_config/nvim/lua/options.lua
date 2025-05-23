-- See `:help vim.o`

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set custom globals
vim.g.presentation_mode = false

------ Vim Options, ------
local options = {
  laststatus = 3,                   -- Ensure only the last window has a status instead of all
  number = true,                    -- Make line numbers default
  hlsearch = false,                 -- Set highlight on search
  mouse = 'a',                      -- Enable mouse mode
  clipboard = 'unnamedplus',        -- Sync clipboard between OS and Neovim.
  breakindent = true,               -- Enable break indent
  undofile = true,                  -- Save undo history
  ignorecase = true,                -- Case-insensitive searching UNLESS \C or capital in search
  smartcase = true,                 -- Overrides the `ignorecase` option when search pattern has a capital
  smartindent = true,               -- smart indenting when starting a new line
  showtabline = 0,                  -- Hide tabline as lualine is leveraged instead
  signcolumn = 'yes',               -- Keep signcolumn on by default
  updatetime = 300,                 -- Decrease update time
  timeoutlen = 300,                 -- time to wait for a mapped sequence to complete (ms)
  completeopt = 'menuone,noselect', -- Set completeopt to have a better completion experience
  termguicolors = true,
  shiftwidth = 2,
  tabstop = 2,
  relativenumber = true,
  scrolloff = 10,
  sidescrolloff = 10,
  splitright = true,
  splitbelow = true,
  -- -- foldlevel = 20,
  -- foldlevelstart = 4,
  foldlevelstart = 99,
  foldlevel = 99,
  -- -- foldnestmax = 3,
  -- foldminlines = 1,
  -- foldmethod = 'expr',
  -- foldexpr = 'nvim_treesitter#foldexpr()',
  -- foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... '.trim(getline(v:foldend)) ]],
  fillchars = 'fold: ',
  title = true,
  titlestring = "IDE - %{substitute(getcwd(),'^.*/','','')}",
}

for k, v in pairs(options) do
  vim.o[k] = v
end
