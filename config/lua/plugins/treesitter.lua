local opts = {
  ensure_installed = {},
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,                                     -- false will disable the whole extension
    disable = { "" },                                  -- list of language that will be disabled
    additional_vim_regex_highlighting = { "org" },     -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  indent = { enable = true, disable = { "yaml" } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  matchup = {
    enable = true,     -- mandatory, false will disable the whole extension
  },
  textobjects = {
    select = {
      enable = true,
      disable = { "latex" },
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aC"] = "@comment.outer",
        ["iC"] = "@comment.outer",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["iv"] = "@conditional.inner",
        ["av"] = "@conditional.outer",
        ["iF"] = "@call.inner",
        ["aF"] = "@call.outer",
        ["aS"] = "@statement.outer",
        ["aB"] = "@block.outer",
        ["iB"] = "@block.inner",
      },
    },
    swap = {
      enable = true,
      swap_previous = {
        ["<M-h>"] = "@parameter.inner",
      },
      swap_next = {
        ["<M-l>"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,       -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = "rounded",
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}

require("nvim-treesitter.configs").setup(opts)
require("treesitter-context").setup({
  patterns = {
    zig = {
      "block",
      "FnProto",
      "function",
      "TopLevelDecl",
      "Statement",
      "IfStatement",
      "WhileStatement",
      "WhileExpr",
      "ForStatement",
      "ForExpr",
      "WhileStatement",
      "WhileExpr",
    },
  },
})
