local ok, _ = pcall(require, "lspconfig")
if not ok then
  return
end

require("lspconfig.ui.windows").default_options.border = "rounded"

local ok_copilot, copilot = pcall(require, "copilot")
if ok_copilot then
  copilot.setup({ suggestion = { auto_trigger = true } })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

-- Rounded borders for hover/signature help
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Capabilities
local _, blink = pcall(require, "blink.cmp")
local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities = blink.get_lsp_capabilities(default_capabilities)

-- on_attach handler
local function on_attach(client, bufnr)
  _ = bufnr
  local illuminate_ok, illuminate = pcall(require, "illuminate")
  local virtualtypes_ok, virtualtypes = pcall(require, "virtualtypes")

  if illuminate_ok then
    illuminate.on_attach(client)
  end

  if virtualtypes_ok and client.server_capabilities.code_lens then
    virtualtypes.on_attach(client)
  end
end

-- Global keymaps (for all buffers with LSP)
local function setup_lsp_keymaps()
  local opts = { noremap = true, silent = true }
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
  end

  map("n", "gd", "<cmd>lua Snacks.picker.lsp_definitions()<CR>", "Go to definition (picker)")
  map("n", "gy", "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>", "Go to type definition (picker)")
  map("n", "gi", "<cmd>lua Snacks.picker.lsp_implementations()<CR>", "Go to implementation (picker)")
  map("n", "gr", "<cmd>lua Snacks.picker.lsp_references()<CR>", "Go to references (picker)")
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration")
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover documentation")
  map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help")
  map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic")
  map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic")
end
setup_lsp_keymaps()

-- LSP server setup
local servers = {
  bashls = "lsp.settings.bashls",
  clangd = "lsp.settings.clangd",
  cssls = "lsp.settings.cssls",
  elmls = "",
  eslint = "",
  fish_lsp = "lsp.settings.fish_lsp",
  gopls = "",
  html = "",
  jsonls = "lsp.settings.jsonls",
  julials = "",
  kotlin_language_server = "",
  lua_ls = "lsp.settings.sumneko_lua",
  marksman = "",
  matlab = "",
  neocmake = "lsp.settings.cmake",
  nil_ls = "",
  nushell = "",
  ocamllsp = "",
  pyright = "lsp.settings.pyright",
  rust_analyzer = "lsp.settings.rust_analyzer",
  solargraph = "",
  texlab = "",
  ts_ls = "",
  vimls = "",
  yamlls = "lsp.settings.yamlls",
  zls = "",
}

vim.lsp.config("*", {
  capabilities = default_capabilities,
})

for server, config_path in pairs(servers) do
  if config_path then
    local ok_conf, conf = pcall(require, config_path)
    if ok_conf then
      vim.lsp.config(server, conf)
    end
  end

  vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    on_attach(client, nil)
  end,
})
