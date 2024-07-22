require("ibl").setup()
require("marks").setup()
require("neoconf").setup()
require("nvim-surround").setup()
require("textcase").setup()
require("orgmode").setup({
  org_agenda_files = { "~/.org/agenda.org" },
  org_default_notes_file = "~/.org/notes.org",
})
require("git-worktree").setup()
require("neogit").setup()
require("trim").setup({
  patterns = {
    [[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
  },
  highlight = true
})
