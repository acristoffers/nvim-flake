vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*rgdi.vitibot.*"] = {
      takeover = "never",
      priority = 1,
    },
  },
}
