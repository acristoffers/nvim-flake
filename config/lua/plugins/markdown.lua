local ok, markdown = pcall(require, "markdown")
if not ok then
  return
end

markdown.setup({
  mappings = {
    inline_surround_toggle = "<leader>mi",      -- (string|boolean) toggle inline style
    inline_surround_toggle_line = "<leader>mI", -- (string|boolean) line-wise toggle inline style
    inline_surround_delete = "<leader>md",      -- (string|boolean) delete emphasis surrounding cursor
    inline_surround_change = "<leader>mc",      -- (string|boolean) change emphasis surrounding cursor
    link_add = "<leader>ml",                    -- (string|boolean) add link
    link_follow = "<leader>mf",                 -- (string|boolean) follow link
    go_curr_heading = "]c",                     -- (string|boolean) set cursor to current section heading
    go_parent_heading = "]p",                   -- (string|boolean) set cursor to parent section heading
    go_next_heading = "]]",                     -- (string|boolean) set cursor to next section heading
    go_prev_heading = "[[",                     -- (string|boolean) set cursor to previous section heading
  },
  on_attach = function(bufnr)
    local map = vim.keymap.set
    local opts = { buffer = bufnr }
    map({ "n", "i" }, "<M-o>", ":MDListItemBelow<CR>", opts)
    map({ "n", "i" }, "<M-O>", ":MDListItemAbove<CR>", opts)
    map("n", "<leader>mx", ":MDTaskToggle<CR>", opts)
    map("x", "<leader>mx", ":MDTaskToggle<CR>", opts)
    map("n", "<leader>mt", ":MDToc<CR>", opts)
  end,
})
