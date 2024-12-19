local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local ok_lsp_setup, lsp_setup = pcall(require, "lsp-setup")
if not ok_lsp_setup then
  return
end

require("lspconfig.ui.windows").default_options.border = "rounded"

local ok_copilot, copilot = pcall(require, "copilot")
if ok_copilot then
  copilot.setup()
end

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

local configs = require("lspconfig.configs")
local util = require("lspconfig.util")
configs["matlab"] = {
  default_config = {
    cmd = { "matlab-lsp" },
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

local cmp_nvim = require("cmp_nvim_lsp")
local lsp_status = require("lsp-status")
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
end

lspconfig.matlab.setup({
  on_attach = on_attach,
  capabilities = default_capabilities,
})

lsp_setup.setup({
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
    bashls = require("lsp.settings.bashls"),
    clangd = require("lsp.settings.clangd"),
    cmake = {},
    cssls = require("lsp.settings.cssls"),
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
    nil_ls = {},
    nushell = {},
    ocamllsp = {},
    pyright = require("lsp.settings.pyright"),
    rust_analyzer = require("lsp.settings.rust_analyzer"),
    solargraph = {},
    texlab = {},
    ts_ls = {},
    vimls = {},
    yamlls = {},
    zls = {},
  },
})
