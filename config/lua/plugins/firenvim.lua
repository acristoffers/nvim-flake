vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*rgdi.vitibot.*"] = {
      takeover = "never",
      priority = 1,
    },
    [".*search.brave.com"] = {
      takeover = "never",
      priority = 1,
    },
    [".*www.google.*"] = {
      takeover = "never",
      priority = 1,
    },
    [".*mastodon.*"] = {
      takeover = "never",
      priority = 1,
    },
  },
}

vim.api.nvim_create_autocmd({'BufEnter'}, {
    pattern = "git.vitibot.fr_*.txt",
    command = "set filetype=markdown tw=70"
})
