vim.loader.enable()

local nix_config_path = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
vim.opt.rtp:append(nix_config_path)

local hostname = "localhost"
local handle = io.popen("hostnamectl hostname")
if handle ~= nil then
  hostname = handle:read("*a")
  handle:close()
end

vim.fn.setenv("FULL_NIX_SHELL", 1)
vim.fn.setenv("HOSTNAME", hostname)

vim.cmd([[
  se nu rnu tabstop=2 shiftwidth=2 smarttab expandtab
  colorscheme catppuccin
  highlight CursorLine guibg=#21222C
]])

if vim.go.loadplugins then
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
