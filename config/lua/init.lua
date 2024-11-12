vim.loader.enable()

local nix_config_path = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
vim.opt.rtp:append(nix_config_path)

vim.schedule(function()
  local hostname = "localhost"
  local handle = io.popen("hostname")
  if handle ~= nil then
    hostname = vim.fn.trim(handle:read("*a"))
    handle:close()
  end
  vim.fn.setenv("HOSTNAME", hostname)
end)

vim.cmd([[
  call setenv("FULL_NIX_SHELL", 1)
  se nu rnu tabstop=2 shiftwidth=2 smarttab expandtab
  colorscheme catppuccin
  highlight CursorLine guibg=#21222C
]])

if vim.go.loadplugins then
  require("config.functions")
  require("config.options")
  require("config.autocommands")
  require("config.keybindings")

  require("plugins.catppuccin")
  require("plugins.alpha")
  require("plugins.bufferline")
  require("plugins.lualine")

  require("plugins.other")
  require("plugins.treesitter")
  require("plugins.luasnip")
  require("plugins.cmp")
  require("plugins.lsp")
  require("plugins.format")
  require("plugins.telescope")
  require("plugins.rainbow")
  require("plugins.autopairs")
  require("plugins.comments")
  require("plugins.gitsigns")
  require("plugins.project")
  require("plugins.dressing")
  require("plugins.notify")
  require("plugins.git-conflict")
  require("plugins.firenvim")
  require("plugins.orgmode")
  require("plugins.trim")
  require("plugins.markdown")
  require("plugins.chatgpt")
  require("plugins.whichkey")

  if vim.g.started_by_firenvim ~= true then
    vim.schedule(function()
      vim.cmd([[
      silent LspStart
      silent bufdo e %
    ]])
    end)
  end
end
