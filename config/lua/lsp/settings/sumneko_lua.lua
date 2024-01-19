return {
    cmd = { "lua-language-server", "server" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    [vim.fn.stdpath("config") .. "/lua/lsp"] = true,
                    [vim.fn.stdpath("config") .. "/lua/config"] = true,
                    [vim.fn.stdpath("config") .. "/lua/plugins"] = true,
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
