require("ibl").setup()
require("neoconf").setup()
require("marks").setup()
require("nvim-surround").setup()
require("orgmode").setup_ts_grammar()
require("orgmode").setup({
	org_agenda_files = { "~/.org/agenda.org" },
	org_default_notes_file = "~/.org/notes.org",
})
