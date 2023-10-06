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
