-- require("mini.ai").setup({ n_lines = 500 })
require("mini.align").setup()
require("mini.comment").setup()
require("mini.icons").setup()
require("mini.move").setup()
require("mini.pairs").setup()
require("mini.snippets").setup()
require("mini.splitjoin").setup()
require("mini.sessions").setup({ autowrite = false })
require("mini.surround").setup({
  respect_selection_type = true,
  custom_surroundings = {
    ['c'] = {
      input = { '`().-()`' },
      output = { left = '`', right = '`' }
    },
    ['C'] = {
      input = { '```().-()```' },
      output = { left = '```', right = '```' }
    },
    ['m'] = {
      input = { '\\%(().-()\\%)' },
      output = { left = '\\( ', right = ' \\)' }
    },
  }
})
