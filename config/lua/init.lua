vim.loader.enable()

if not vim.go.loadplugins then
    vim.cmd([[se nu rnu]])
    vim.cmd([[se tabstop=8]])
    vim.cmd([[se shiftwidth=4 smarttab expandtab]])
else
    require("plugins.alpha")
    require("plugins.bufferline")
    require("plugins.lualine")

    require("config.autocommands")
    require("config.keybindings")
    require("config.options")

    require("plugins.other")
    require("plugins.autopairs")
    require("plugins.cmp")
    require("plugins.comments")
    require("plugins.gitsigns")
    require("plugins.lsp")
    require("plugins.luasnip")
    require("plugins.treesitter")
end
