vim.cmd([[
    packadd indent-blankline.nvim
    packadd marks.nvim
    packadd neoconf.nvim
    packadd nvim-lspconfig
    packadd nvim-surround
    packadd nvim-treesitter
    packadd orgmode
    packadd undotree
    packadd vim-fish
    packadd vim-illuminate
    packadd vim-indent-object
    packadd vim-lion
    packadd vim-repeat
    packadd vim-sneak
]])

require("ibl").setup()
require("neoconf").setup()
require("marks").setup()
require("nvim-surround").setup()
require("orgmode").setup_ts_grammar()
require("orgmode").setup({
	org_agenda_files = { "~/.org/agenda.org" },
	org_default_notes_file = "~/.org/notes.org",
})
