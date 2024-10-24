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
  mappings = {
    inline_surround_toggle = "mgs",       -- (string|boolean) toggle inline style
    inline_surround_toggle_line = "mgss", -- (string|boolean) line-wise toggle inline style
    inline_surround_delete = "mds",       -- (string|boolean) delete emphasis surrounding cursor
    inline_surround_change = "mcs",       -- (string|boolean) change emphasis surrounding cursor
    link_add = "mgl",                     -- (string|boolean) add link
    link_follow = "mgx",                  -- (string|boolean) follow link
    go_curr_heading = "m]c",              -- (string|boolean) set cursor to current section heading
    go_parent_heading = "m]p",            -- (string|boolean) set cursor to parent section heading
    go_next_heading = "m]]",              -- (string|boolean) set cursor to next section heading
    go_prev_heading = "m[[",              -- (string|boolean) set cursor to previous section heading
  },
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
