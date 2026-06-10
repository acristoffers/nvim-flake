local ok, orgmode = pcall(require, "orgmode")
if not ok then
  return
end

orgmode.setup({
  org_agenda_files = { "~/.org/agenda.org" },
  org_default_notes_file = "~/.org/notes.org",
})

-- Keep regex syntax active alongside treesitter (mirrors additional_vim_regex_highlighting)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "org",
  callback = function(args)
    vim.bo[args.buf].syntax = "org"
  end,
})
