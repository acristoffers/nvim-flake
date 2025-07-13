local ignored_urls = {
  ".*rgdi.vitibot.*",
  ".*search.brave.com",
  ".*www.google.*",
  ".*mastodon.*",
  ".*instagram.*",
  "matlab.mathworks.com"
}

local exceptions = {}

for _, url in pairs(ignored_urls) do
  exceptions[url] = {
    takeover = "never",
    priority = 1,
  }
end

vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = exceptions,
}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "git.vitibot.fr_*.txt",
  command = "set filetype=markdown tw=70",
})
