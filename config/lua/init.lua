vim.loader.enable()

if not vim.go.loadplugins then
    vim.cmd([[se nu rnu]])
    vim.cmd([[se tabstop=8]])
    vim.cmd([[se shiftwidth=4 smarttab expandtab]])
else
    require("config.autocommands")
    require("config.keybindings")
    require("config.options")

    vim.schedule(function()
        require("plugins.alpha")
        require("plugins.bufferline")
        require("plugins.lualine")

        vim.schedule(function()
            require("plugins.other")
            require("plugins.autopairs")
            require("plugins.cmp")
            require("plugins.comments")
            require("plugins.gitsigns")
            require("plugins.lsp")
            require("plugins.luasnip")
            require("plugins.treesitter")
            require("plugins.telescope")
            require("plugins.whichkey")

            vim.cmd([[ bufdo LspStart ]])
        end)
    end)
end
