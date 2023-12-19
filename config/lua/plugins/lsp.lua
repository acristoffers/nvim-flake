require("lspconfig.ui.windows").default_options.border = "rounded"

local config = {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}
vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local util = require("lspconfig.util")
local configs = require("lspconfig.configs")
configs["matlab"] = {
    default_config = {
        cmd = { vim.fn.expand("~/.nix-profile/bin/matlab-lsp") },
        filetypes = { "matlab" },
        single_file_support = true,
        root_dir = util.root_pattern(".git", ".projectile"),
    },
    docs = {
        description = [[ MATLAB LSP ]],
        default_config = {
            root_dir = [[ util.root_pattern(".git", ".projectile") ]],
        },
    },
}

local lsp_status = require("lsp-status")
local cmp_nvim = require("cmp_nvim_lsp")
local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities = cmp_nvim.default_capabilities(default_capabilities)
default_capabilities = vim.tbl_extend("keep", default_capabilities, lsp_status.capabilities)

local function on_attach(client, bufnr)
    _ = bufnr
    local illuminate_ok, illuminate = pcall(require, "illuminate")
    local virtualtypes_ok, virtualtypes = pcall(require, "virtualtypes")
    if illuminate_ok then
        illuminate.on_attach(client)
    end
    lsp_status.on_attach(client)
    if virtualtypes_ok and client.server_capabilities.code_lens then
        virtualtypes.on_attach(client)
    end
    local moses_ok, Moses = pcall(require, "moses")
    if moses_ok then
        local noformat = { "tsserver", "lua_ls", "jsonls" }
        if Moses.include(noformat, client.name) then
            client.server_capabilities.document_formatting = false
        else
            require("lsp-setup.utils").format_on_save(client)
        end
    end
end

local lspconfig = require("lspconfig")
lspconfig.matlab.setup({
    on_attach = on_attach,
    capabilities = default_capabilities,
})

require("lsp-setup").setup({
    default_mappings = false,
    -- Custom mappings, will overwrite the default mappings for the same key
    mappings = {
        gd = 'lua require"telescope.builtin".lsp_definitions()',
        gy = "lua vim.lsp.buf.type_definition()",
        gi = 'lua require"telescope.builtin".lsp_implementations()',
        gr = 'lua require"telescope.builtin".lsp_references()',
        gD = "lua vim.lsp.buf.declaration()",
        K = "lua vim.lsp.buf.hover()",
        ["<C-k>"] = "lua vim.lsp.buf.signature_help()",
        ["[d"] = "lua vim.diagnostic.goto_prev()",
        ["]d"] = "lua vim.diagnostic.goto_next()",
    },
    -- Global on_attach
    on_attach = on_attach,
    -- Global capabilities
    capabilities = default_capabilities,
    -- Configuration of LSP servers
    servers = {
        -- Install LSP servers automatically
        -- LSP server configuration please see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        bashls = {},
        clangd = require("lsp.settings.clangd"),
        cmake = {},
        cssls = require("lsp.settings.cssls"),
        elixirls = require("lsp.settings.emmet_ls"),
        elmls = {},
        erlangls = {},
        eslint = {},
        gopls = {},
        html = {},
        jsonls = require("lsp.settings.jsonls"),
        julials = {},
        kotlin_language_server = {},
        lua_ls = require("lsp.settings.sumneko_lua"),
        marksman = {},
        ocamllsp = {},
        pyright = require("lsp.settings.pyright"),
        rnix = {},
        rust_analyzer = require("lsp.settings.rust_analyzer"),
        solargraph = {},
        texlab = {},
        tsserver = {},
        vimls = {},
        vuels = {},
        zls = {},
    },
})

local function stylua()
    local futil = require "formatter.util"
    return {
        exe = "stylua",
        args = {
            "--search-parent-directories",
            "--indent-type", "None",
            "--line-endings", "Unix",
            "--line-endings", "AutoPreferDouble",
            "--indent-type", "Spaces",
            "--sort-requires",
            "--stdin-filepath",
            futil.escape_path(futil.get_current_buffer_file_path()),
            "--",
            "-",
        },
        stdin = true,
    }
end

require("formatter").setup({
    filetype = {
        fish = require("formatter.filetypes.fish").fishindent,
        html = require("formatter.filetypes.html").htmlbeautify,
        json = require("formatter.filetypes.json").jq,
        lua = stylua(),
        nix = require("formatter.filetypes.nix").nixpkgs_fmt,
        python = require("formatter.filetypes.python").black,
        sh = require("formatter.filetypes.sh").shfmt,
        toml = require("formatter.filetypes.toml").taplo,
        yaml = require("formatter.filetypes.yaml").yamlfmt,
    },
})

lsp_status.config({
    indicator_errors = "",
    indicator_warnings = "",
    indicator_info = "",
    indicator_hint = "",
    indicator_ok = "",
    status_symbol = "",
})
lsp_status.register_progress()
