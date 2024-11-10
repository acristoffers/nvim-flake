local ok, gitconflict = pcall(require, "git-conflict")
if not ok then
  return
end

vim.cmd([[
  highlight DiffCurrent  guibg=#405d7e guifg=#50fa7b
  highlight DiffIncoming guibg=#282136 guifg=#50fa7b
]])

gitconflict.setup({
  default_commands = true, -- disable commands created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  list_opener = "copen", -- command or function to open the conflicts list
  highlights = { -- They must have background color, otherwise the default color will be used
    current = "DiffCurrent",
    incoming = "DiffIncoming",
  },
  default_mappings = {
    ours = "ch",
    theirs = "co",
    none = "cn",
    both = "cb",
    next = "]x",
    prev = "[x",
  },
})
