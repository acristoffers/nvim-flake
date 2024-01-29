local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  colorcolumn = "121",
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  cursorline = true,                       -- highlight the current line
  expandtab = true,                        -- convert tabs to spaces
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  number = true,                           -- set numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  pumheight = 10,                          -- pop up menu height
  relativenumber = true,                   -- set relative numbered lines
  scrolloff = 0,                           -- is one of my fav
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  shortmess = "",
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 4,                         -- always show tabs
  sidescrolloff = 0,
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  softtabstop = 2,
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  tabstop = 2,                             -- insert 2 spaces for a tab
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  textwidth = 120,
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  wrap = false,                            -- display lines as one long line
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd([[ colorscheme dracula ]])
vim.cmd([[ highlight CursorLine guibg=#21222C ]])

vim.cmd([[ set whichwrap+=<,>,[,],h,l ]])
vim.cmd([[ set iskeyword+=- ]])
vim.cmd([[ set laststatus=3 ]])
vim.cmd([[ set nrformats=bin,octal,hex,alpha ]])

vim.cmd([[ set foldmethod=expr ]])
vim.cmd([[ set foldexpr=nvim_treesitter#foldexpr() ]])
vim.cmd([[ set nofoldenable ]])

vim.cmd([[ let g:sneak#label = 1 ]])
vim.cmd([[ let g:sneak#s_next = 1 ]])
vim.cmd([[ map gS <Plug>Sneak_, ]])
vim.cmd([[ map gs <Plug>Sneak_; ]])
vim.cmd([[ highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan ]])
vim.cmd([[ highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow ]])
vim.cmd([[ let g:sneak#prompt = '🔎  ' ]])

vim.api.nvim_set_hl(0, "@variable.matlab", { link = "Identifier" })

vim.env.PYTHONPATH = nil
vim.env.PIP_PREFIX = nil

vim.g.mapleader = " "
vim.g.lion_squeeze_spaces = 1
if vim.loop.os_uname().sysname == "Darwin" then
  vim.g.vimtex_view_method = "skim"
else
  vim.g.vimtex_view_general_viewer = "okular"
  vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
end
vim.g.Tex_FoldedSections = ""
vim.g.Tex_FoldedEnvironments = ""
vim.g.Tex_FoldedMisc = ""

function SetTab(num)
  vim.opt.shiftwidth = num
  vim.opt.tabstop = num
  vim.opt.softtabstop = num
end
