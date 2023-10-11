vim.cmd([[
    packadd bufdelete.nvim
    packadd bufferline.nvim
    packadd cmp-buffer
    packadd cmp-cmdline
    packadd cmp_luasnip
    packadd cmp-nvim-lsp
    packadd cmp-nvim-lsp-signature-help
    packadd cmp-nvim-lua
    packadd cmp-path
    packadd dressing.nvim
    packadd FixCursorHold.nvim
    packadd flutter-tools.nvim
    packadd formatter.nvim
    packadd friendly-snippets
    packadd gitsigns.nvim
    packadd hop.nvim
    packadd indent-blankline.nvim
    packadd julia-vim
    packadd lsp-colors.nvim
    packadd lsp-status.nvim
    packadd luasnip
    packadd marks.nvim
    packadd mini.nvim
    packadd neoconf.nvim
    packadd neodev.nvim
    packadd nvim-autopairs
    packadd nvim-cmp
    packadd nvim-fzf
    packadd nvim-lspconfig
    packadd nvim-notify
    packadd nvim-surround
    packadd nvim-treesitter
    packadd nvim-treesitter-context
    packadd nvim-treesitter-textobjects
    packadd nvim-ts-context-commentstring
    packadd nvim-ts-rainbow2
    packadd nvim-web-devicons
    packadd orgmode
    packadd plenary.nvim
    packadd popup.nvim
    packadd rust-tools.nvim
    packadd telescope-media-files.nvim
    packadd telescope.nvim
    packadd telescope-ui-select.nvim
    packadd undotree
    packadd vim-better-whitespace
    packadd vim-fish
    packadd vim-illuminate
    packadd vim-indent-object
    packadd vim-lion
    packadd vim-matchup
    packadd vimplugin-lsp-setup
    packadd vim-repeat
    packadd vim-sneak
    packadd vimtex
    packadd vim-textobj-user
    packadd vim-tridactyl
    packadd virtual-types.nvim
]])

require("neoconf").setup()
require("mini.align").setup()
require("flutter-tools").setup({})
require("mini.pairs").setup({})
require("nvim-surround").setup()
require("marks").setup()
require("orgmode").setup_ts_grammar()
require("orgmode").setup({
	org_agenda_files = { "~/.org/agenda.org" },
	org_default_notes_file = "~/.org/notes.org",
})
require("hop").setup({})
require("notify").setup({
	timeout = 3000,
	max_height = function()
		return math.floor(vim.o.lines * 0.75)
	end,
	max_width = function()
		return math.floor(vim.o.columns * 0.75)
	end,
})
require("dressing").setup({
	background_colour = "Normal",
	fps = 30,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	level = 2,
	minimum_width = 50,
	render = "default",
	stages = "fade_in_slide_out",
	timeout = 5000,
	top_down = true,
})
