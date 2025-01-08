local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

local ok_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_nvim_lsp then
  cmp_nvim_lsp.setup()
end

local ok_cmp_luasnip, cmp_luasnip = pcall(require, "cmp_luasnip")
if ok_cmp_luasnip then
  local cmp_luasnip_group = vim.api.nvim_create_augroup("cmp_luasnip", {})
  vim.api.nvim_create_autocmd("User", {
    pattern = "LuasnipCleanup",
    callback = function()
      cmp_luasnip.clear_cache()
    end,
    group = cmp_luasnip_group,
  })
  vim.api.nvim_create_autocmd("User", {
    pattern = "LuasnipSnippetsAdded",
    callback = function()
      cmp_luasnip.refresh()
    end,
    group = cmp_luasnip_group,
  })
end

local opts = function()
  local ok_luasnip, luasnip = pcall(require, "luasnip")
  if not ok_luasnip then
    return
  end

  local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
  end

  --   פּ ﯟ   some other good icons
  local kind_icons = {
    Text = "󰉿",
    Method = "m",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
  }
  -- find more here: https://www.nerdfonts.com/cheat-sheet

  return {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({ select = false }), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<cr>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lsp_signature_help = "[LSP-SIG]",
          nvim_lua = "[NVIM_LUA]",
          luasnip = "[Snippet]",
          orgmode = "[ORG]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp",                group_index = 2 },
      { name = "nvim_lsp_signature_help", group_index = 2 },
      { name = "nvim_lua",                group_index = 2 },
      { name = "luasnip",                 group_index = 2 },
      { name = "orgmode",                 group_index = 2 },
      { name = "path",                    group_index = 2 },
    }, {
      { name = "buffer", keyword_length = 4 },
    }),
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    completion = {
      autocomplete = false,
      completeopt = 'menu,menuone,noselect'
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = false,
      native_menu = false,
    },
  }
end

cmp.setup(opts())
