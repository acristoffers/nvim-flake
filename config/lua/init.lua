vim.g.plugins_loaded = false

require("config.options")
require("config.autocommands")
require("config.keybindings")

require("plugins.alpha")
require("plugins.bufferline")
require("plugins.lualine")
require("plugins.whichkey")

vim.cmd([[ colorscheme dracula ]])
vim.cmd([[ highlight CursorLine guibg=#21222C ]])
vim.cmd([[ set foldmethod=expr ]])
vim.cmd([[ set foldexpr=nvim_treesitter#foldexpr() ]])
vim.cmd([[ set nofoldenable ]])

vim.api.nvim_set_hl(0, "@variable.matlab", { link = "Identifier" })
