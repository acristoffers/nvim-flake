vim.g.no_plugin_maps = true

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@function.outer"] = "V",
    },
    include_surrounding_whitespace = false,
  },
  move = {
    set_jumps = true,
  },
})

local opts = { silent = true, noremap = true }

local select = require("nvim-treesitter-textobjects.select")
local keymaps = {
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ac"] = "@class.outer",
  ["ic"] = "@class.inner",
  ["aC"] = "@comment.outer",
  ["iC"] = "@comment.outer",
  ["aa"] = "@parameter.outer",
  ["ia"] = "@parameter.inner",
  ["al"] = "@loop.outer",
  ["il"] = "@loop.inner",
  ["av"] = "@conditional.outer",
  ["iv"] = "@conditional.inner",
  ["aF"] = "@call.outer",
  ["iF"] = "@call.inner",
  ["aS"] = "@statement.outer",
  ["aB"] = "@block.outer",
  ["iB"] = "@block.inner",
}

for key, query in pairs(keymaps) do
  vim.keymap.set({ "x", "o" }, key, function()
    select.select_textobject(query, "textobjects")
  end, opts)
end

local swap = require("nvim-treesitter-textobjects.swap")
vim.keymap.set("n", "<M-l>", function() swap.swap_next("@parameter.inner") end, opts)
vim.keymap.set("n", "<M-h>", function() swap.swap_previous("@parameter.inner") end, opts)

local move = require("nvim-treesitter-textobjects.move")
local jumps = {
  goto_next_start     = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
  goto_next_end       = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
  goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
  goto_previous_end   = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
}

for fn, maps in pairs(jumps) do
  for key, query in pairs(maps) do
    vim.keymap.set({ "n", "x", "o" }, key, function()
      move[fn](query, "textobjects")
    end, opts)
  end
end
