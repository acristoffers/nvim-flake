vim.loader.enable()

local nix_config_path = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
vim.opt.rtp:append(nix_config_path)

vim.fn.setenv("FULL_NIX_SHELL", 1)

if not vim.go.loadplugins then
  vim.cmd([[se nu rnu]])
  vim.cmd([[se tabstop=8]])
  vim.cmd([[se shiftwidth=4 smarttab expandtab]])
else
  require("config.autocommands")
  require("config.keybindings")
  require("config.options")
  require("plugins.alpha")
  require("plugins.rainbow")

  require("plugins.bufferline")
  require("plugins.lualine")

  require("plugins.other")
  require("plugins.autopairs")
  require("plugins.cmp")
  require("plugins.comments")
  require("plugins.gitsigns")
  require("plugins.lsp")
  require("plugins.luasnip")
  require("plugins.treesitter")
  require("plugins.project")
  require("plugins.telescope")
  require("plugins.git-conflict")
  require("config.xmlattr")
  require("plugins.whichkey")
  require("plugins.chatgpt")

  vim.schedule(function()
    vim.cmd([[
      silent LspStart
      silent bufdo e %
    ]])
  end)
end
