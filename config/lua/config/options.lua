vim.g.mapleader = " "

vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

local options = {
  autoindent = true,
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  colorcolumn = "121",
  commentstring = "",
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  cursorline = true,                       -- highlight the current line
  encoding = "utf-8",                      -- the encoding used for the editor
  expandtab = true,                        -- convert tabs to spaces
  fileencoding = "utf-8",                  -- the encoding written to a file
  foldenable = false,
  foldexpr = "v:lua.vim.treesitter.foldexpr()",
  foldmethod = "expr",
  guifont = "JetBrainsMonoNL Nerd Font",
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  inccommand = "split",                    -- show substitutions in a split window
  laststatus = 3,
  mouse = "a",                             -- allow the mouse to be used in neovim
  mousemoveevent = true,
  nrformats = "bin,octal,hex,alpha",
  number = true,                           -- set numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  pumheight = 10,                          -- pop up menu height
  relativenumber = true,                   -- set relative numbered lines
  scrolloff = 0,                           -- is one of my fav
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  shortmess = "F",
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,                         -- never show tabs
  sidescrolloff = 0,
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                        -- smart case
  smartindent = true,
  softtabstop = 2,
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  tabstop = 2,                             -- insert 2 spaces for a tab
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  textwidth = 100,
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  wrap = false,                            -- display lines as one long line
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.runtimepath:prepend(vim.fn.expand("~/.local/share/nvim"))
