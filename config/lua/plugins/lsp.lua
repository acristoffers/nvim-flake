require("lspconfig.ui.windows").default_options.border = "rounded"

require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
require("copilot_cmp").setup()

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
  local moses_ok, Moses = pcall(require, "moses")
  if moses_ok then
    local noformat = { "ts_ls", "lua_ls", "jsonls" }
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
    ocamllsp = {},
    pyright = require("lsp.settings.pyright"),
    nil_ls = {},
    rust_analyzer = require("lsp.settings.rust_analyzer"),
    solargraph = {},
    texlab = {},
    ts_ls = {},
    vimls = {},
    vuels = {},
    yamlls = {},
    zls = {},
  },
})

local function stylua()
  local futil = require("formatter.util")
  return {
    exe = "stylua",
    args = {
      "--indent-type", "Spaces",
      "--line-endings", "Unix",
      "--indent-width", "2",
      "--search-parent-directories",
      "--sort-requires",
      "--stdin-filepath",
      futil.escape_path(futil.get_current_buffer_file_path()),
      "--",
      "-",
    },
    stdin = true,
  }
end

local function tidy()
  return {
    exe = "tidy",
    args = {
      "-quiet",
      "-xml",
      "--indent auto",
      "--indent-spaces 2",
      "--vertical-space yes",
      "--tidy-mark no",
      "--wrap 100",
    },
    stdin = true,
    try_node_exe = true,
  }
end

local function mdformat()
  return {
    exe = "mdformat",
    args = {
      "--wrap", "100",
      "--end-of-line", "lf",
      "--number",
    },
    stdin = false,
  }
end

local function black()
  local futil = require("formatter.util")
  return {
    exe = "black",
    args = {
      "-q",
      "-l", "100",
      "--stdin-filename", futil.escape_path(futil.get_current_buffer_file_name()),
      "-"
    },
    stdin = true,
  }
end

local function wbproto_beautifier()
  return {
    exe = "wbproto-beautifier",
    stdin = true,
  }
end

local function yamlfmt()
  local default = require("formatter.filetypes.yaml").yamlfmt()
  default.args = {
    "-in",
    "-formatter",
    "retain_line_breaks_single=true,eof_newline=true,include_document_start=true,line_ending=lf,trim_trailing_whitespace=true"
  }
  return default
end

require("formatter").setup({
  filetype = {
    c = require("formatter.filetypes.c").clangformat,
    cpp = require("formatter.filetypes.cpp").clangformat,
    fish = require("formatter.filetypes.fish").fishindent,
    html = tidy,
    javascript = require("formatter.filetypes.javascript").clangformat,
    json = require("formatter.filetypes.json").jq,
    lua = stylua,
    markdown = mdformat,
    nix = require("formatter.filetypes.nix").nixpkgs_fmt,
    python = black,
    sh = require("formatter.filetypes.sh").shfmt,
    toml = require("formatter.filetypes.toml").taplo,
    wbproto = wbproto_beautifier,
    xhtml = tidy,
    xml = tidy,
    yaml = yamlfmt,
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
