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
  },
}
