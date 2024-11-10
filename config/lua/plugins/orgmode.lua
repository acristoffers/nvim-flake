local ok, orgmode = pcall(require, "orgmode")
if not ok then
  return
end

orgmode.setup({
  org_agenda_files = { "~/.org/agenda.org" },
  org_default_notes_file = "~/.org/notes.org",
})
