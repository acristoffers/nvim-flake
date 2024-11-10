local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  return
end

catppuccin.setup({
  integrations = {
    alpha = true,
    cmp = true,
    dap = true,
    dap_ui = true,
    fzf = true,
    gitsigns = true,
    hop = true,
    illuminate = { enabled = true, lsp = false },
    indent_blankline = { enabled = true, scope_color = "lavender", colored_indent_levels = true, },
    leap = true,
    markdown = true,
    mini = { enabled = true, indentscope_color = "", },
    neogit = true,
    notify = true,
    nvim_surround = true,
    nvimtree = true,
    rainbow_delimiters = true,
    semantic_tokens = true,
    telescope = { enabled = true },
    treesitter = true,
    treesitter_context = true,
    which_key = true,
  }
})
