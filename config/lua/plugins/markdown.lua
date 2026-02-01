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
    local opts = { buffer = bufnr }
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
    end

    map({ "n", "i" }, "<M-o>", "<cmd>MDListItemBelow<CR>", "Insert list item below")
    map({ "n", "i" }, "<M-O>", "<cmd>MDListItemAbove<CR>", "Insert list item above")
    map("n", "<leader>mx", "<cmd>MDTaskToggle<CR>", "Toggle task")
    map("x", "<leader>mx", "<cmd>MDTaskToggle<CR>", "Toggle task")
    map("n", "<leader>mt", "<cmd>MDToc<CR>", "Insert table of contents")
  end,
})
