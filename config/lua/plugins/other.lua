require("ibl").setup()
require("marks").setup()
require("neoconf").setup()
require('mini.align').setup()
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
  highlight = false
})
require("markdown").setup({
  on_attach = function(bufnr)
    local map = vim.keymap.set
    local opts = { buffer = bufnr }
    map({ 'n', 'i' }, '<M-o>', ':MDListItemBelow<CR>', opts)
    map({ 'n', 'i' }, '<M-O>', ':MDListItemAbove<CR>', opts)
    map('n', '<M-c>', ':MDTaskToggle<CR>', opts)
    map('x', '<M-c>', ':MDTaskToggle<CR>', opts)
    map('n', '<M-t>', ':MDToc<CR>', opts)
  end,
})
