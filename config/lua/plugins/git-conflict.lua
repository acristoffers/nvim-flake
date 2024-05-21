local gitconflict = require("git-conflict")

gitconflict.setup({
  default_commands = true,       -- disable commands created by this plugin
  disable_diagnostics = false,   -- This will disable the diagnostics in a buffer whilst it is conflicted
  list_opener = "copen",         -- command or function to open the conflicts list
  highlights = {                 -- They must have background color, otherwise the default color will be used
    incoming = "DiffAdd",
    current = "DiffText",
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
