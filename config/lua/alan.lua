vim.g.nix_config_path = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
vim.opt.runtimepath:prepend(vim.g.nix_config_path)

vim.g.windowswap_map_keys = 0

vim.schedule(function()
  local hostname = "localhost"
  local handle = io.popen("hostname")
  if handle ~= nil then
    hostname = vim.fn.trim(handle:read("*a"))
    handle:close()
  end
  vim.fn.setenv("HOSTNAME", hostname)
end)

vim.cmd([[ call setenv("FULL_NIX_SHELL", 1) ]])

require("config.autocommands")
require("config.functions")
require("config.keybindings")
require("config.options")

require("plugins.snacks")
require("plugins.catppuccin")
require("plugins.mini")
require("plugins.blink")
require("plugins.codecompanion")
require("plugins.dap")
require("plugins.dressing")
require("plugins.firenvim")
require("plugins.format")
require("plugins.git-conflict")
require("plugins.gitsigns")
require("plugins.ledger")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.markdown")
require("plugins.markview")
require("plugins.orgmode")
require("plugins.other")
require("plugins.project")
require("plugins.rainbow")
require("plugins.textobjects")
require("plugins.trim")
require("plugins.whichkey")
