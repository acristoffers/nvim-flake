local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  return
end

catppuccin.setup({
  integrations = {
    blink_cmp = true,
    fzf = true,
    gitsigns = true,
    hop = true,
    markdown = true,
    mini = { enabled = true, indentscope_color = "", },
    neogit = true,
    rainbow_delimiters = true,
    semantic_tokens = true,
    snacks = true,
    telescope = { enabled = true },
    treesitter = true,
    treesitter_context = true,
    which_key = true,
  }
})
