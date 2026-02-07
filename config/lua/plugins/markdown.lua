local ok, markdown = pcall(require, "markdown")
if not ok then
  return
end

markdown.setup({
  mappings = {
    inline_surround_toggle      = "<leader>msi", -- (string|boolean) toggle inline style
    inline_surround_toggle_line = "<leader>msI", -- (string|boolean) line-wise toggle inline style
    inline_surround_delete      = "<leader>msd", -- (string|boolean) delete emphasis surrounding cursor
    inline_surround_change      = "<leader>msc", -- (string|boolean) change emphasis surrounding cursor
    link_add                    = "<leader>mla", -- (string|boolean) add link
    link_follow                 = "<leader>mlf", -- (string|boolean) follow link
    go_curr_heading             = "<leader>mhc", -- (string|boolean) set cursor to current section heading
    go_parent_heading           = "<leader>mhP", -- (string|boolean) set cursor to parent section heading
    go_next_heading             = "<leader>mhn", -- (string|boolean) set cursor to next section heading
    go_prev_heading             = "<leader>mhp", -- (string|boolean) set cursor to previous section heading
  },
  on_attach = function(bufnr)
    local opts = { buffer = bufnr }
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
    end

    map({ "n", "i" }, "<M-o>", "<cmd>MDListItemBelow<CR>", "Insert list item below")
    map({ "n", "i" }, "<M-O>", "<cmd>MDListItemAbove<CR>", "Insert list item above")
    map({ "n", "x" }, "<leader>mx", "<cmd>MDTaskToggle<CR>", "Toggle task")
    map("n", "<leader>mts", "<cmd>MDToc<CR>", "Show table of contents")
    map("n", "<leader>mti", "<cmd>MDInsertToc<CR>", "Insert table of contents")

    local whichkey_ok, whichkey = pcall(require, "which-key")
    if whichkey_ok then
      whichkey.add({
        {
          nowait = true,
          remap = false,
          { "<leader>m",  group = "Markdown" },
          { "<leader>mh", group = "Header" },
          { "<leader>ml", group = "Link" },
          { "<leader>ms", group = "Surround" },
          { "<leader>mt", group = "TOC" },
        },
      })
    end
  end,
})
