local ok_hop, hop = pcall(require, "hop")
if ok_hop then
  hop.setup({})
end

--------------------------------------------------------------------------------
--                                                                            --
--                           Whichkey Configuration                           --
--                                                                            --
--------------------------------------------------------------------------------

local ok_wk, which_key = pcall(require, "which-key")
if not ok_wk then
  return
end

local options = {
  preset = "modern",
  delay = 200,
  spec = {
    {
      "<leader> ",
      ":lua Snacks.picker.files()<cr>",
      desc = "Find File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>o",
      group = "Org",
      nowait = true,
      remap = false,
    },
    {
      "<leader>b",
      group = "Buffers",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bb",
      ":lua Snacks.picker.buffers()<cr>",
      desc = "Go to Buffer (Picker)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bc",
      group = "Close",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bo",
      ":lua Snacks.bufdelete.other()<cr>",
      desc = "Close Others",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bK",
      ":bd!<cr>",
      desc = "Force Close Buffer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bk",
      ":bd<cr>",
      desc = "Close Buffer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bn",
      ":bn<cr>",
      desc = "Next",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bp",
      ":bp<cr>",
      desc = "Previous",
      nowait = true,
      remap = false,
    },
    {
      "<leader>br",
      ":e!<cr>",
      desc = "Reload current buffer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>bs",
      group = "Sort",
      nowait = true,
      remap = false,
    },
    { "<leader>c", group = "Code", nowait = true, remap = false },
    { "<leader>cc", ":CodeCompanionChat Toggle<cr>", desc = "Toggle LLM", nowait = true, remap = false },
    { "<leader>ch", ":LspClangdSwitchSourceHeader<cr>", desc = "Switch .h/.cpp", nowait = true, remap = false },
    { "<leader>ct", ":Trim<cr>", desc = "Trim trailling spaces", nowait = true, remap = false },
    { "<leader>cf", ":Format<cr>", desc = "Format (formatter.nvim)", nowait = true, remap = false },
    { "<leader>l", group = "LSP", nowait = true, remap = false },
    {
      "<leader>la",
      ":lua vim.lsp.buf.code_action()<cr>",
      desc = "Code Action",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lA",
      GetCodeActionsAndApplyGlobally,
      desc = "Code Action (Apply in buffer)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ld",
      ":lua Snacks.picker.diagnostics_buffer()<cr>",
      desc = "Diagnostics (Buffer)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lD",
      ":lua Snacks.picker.diagnostics()<cr>",
      desc = "Diagnostics (Workspace)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lf",
      ":lua vim.lsp.buf.format()<cr>",
      desc = "Format (LSP)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>li",
      ":LspInfo<cr>",
      desc = "Info",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lI",
      ":LspInstallInfo<cr>",
      desc = "Installer Info",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lj",
      vim.diagnostic.goto_next,
      desc = "Next Diagnostic",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lk",
      vim.diagnostic.goto_prev,
      desc = "Prev Diagnostic",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ll",
      vim.lsp.codelens.run,
      desc = "CodeLens Action",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lo",
      vim.diagnostic.open_float,
      desc = "Open Float",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lq",
      vim.diagnostic.setloclist,
      desc = "Quickfix",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lQ",
      ":lua Snacks.picker.loclist()<cr>",
      desc = "Quickfix (Picker)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lr",
      vim.lsp.buf.rename,
      desc = "Rename",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ls",
      ":lua Snacks.picker.lsp_symbols()<cr>",
      desc = "Document Symbols",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lS",
      ":lua Snacks.picker.lsp_workspace_symbols()<cr>",
      desc = "Workspace Symbols",
      nowait = true,
      remap = false,
    },
    {
      "<leader>t",
      group = "Toggle",
      nowait = true,
      remap = false,
    },
    {
      "<leader>te",
      ":lua Snacks.explorer()<CR>",
      desc = "File Tree",
      nowait = true,
      remap = false,
    },
    {
      "<leader>tf",
      function()
        if vim.opt_local.foldmethod:get() == "expr" then
          vim.opt_local.foldmethod = "manual"
        else
          vim.opt_local.foldmethod = "expr"
        end
        vim.cmd [[ help fdm ]]
        vim.cmd [[ helpclose ]]
      end,
      desc = "Fold method",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ti",
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      desc = "Inlay Hints",
      nowait = true,
      remap = false,
    },
    {
      "<leader>tu",
      ":UndotreeToggle<cr>",
      desc = "Undo Tree",
      nowait = true,
      remap = false,
    },
    {
      "<leader>tc",
      ":ColorizerToggle<cr>",
      desc = "Colorizer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ts",
      ":nohlsearch<cr>",
      desc = "Highlight",
      nowait = true,
      remap = false,
    },
    {
      "<leader>f",
      group = "File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fa",
      ":silent wa<cr>",
      desc = "Save All",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fw",
      SaveNormalizedUTF8,
      desc = "Save File (Fix Encoding)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fg",
      ":lua Snacks.picker.git_files()<cr>",
      desc = "Find Git File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fh",
      ":wshada!<cr>",
      desc = "Save shada (fixes overpersistent marks)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fL",
      ":e /home/alan/.org/finances/2025.ledger<cr>",
      desc = "Open Ledger",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fn",
      ":ene!<cr>",
      desc = "New file",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fo",
      ":lua Snacks.picker.files()<cr>",
      desc = "Open File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fr",
      ":lua Snacks.picker.recent()<CR>",
      desc = "Recent File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fS",
      ":silent noa w<cr>",
      desc = "Save File (no autocommands)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>fs",
      ":silent w<cr>",
      desc = "Save File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>g",
      group = "Git",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gR",
      ":lua require 'gitsigns'.reset_buffer()<cr>",
      desc = "Reset Buffer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gb",
      ":lua Snacks.picker.git_branches()<cr>",
      desc = "Checkout branch",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gc",
      ":GitConflictRefresh<cr>",
      desc = "Git Conflict Refresh",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gd",
      ":Gitsigns diffthis HEAD<cr>",
      desc = "Git Diff",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gg",
      require("neogit").open,
      desc = "Neogit",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gh",
      ":AdvancedGitSearch search_log_content_file<cr>",
      desc = "Wayback Machine (History)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gj",
      ":lua require 'gitsigns'.next_hunk()<cr>",
      desc = "Next Hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gk",
      ":lua require 'gitsigns'.prev_hunk()<cr>",
      desc = "Prev Hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gl",
      ":lua require 'gitsigns'.blame_line()<cr>",
      desc = "Blame",
      nowait = true,
      remap = false,
    },
    {
      "<leader>go",
      ":lua Snacks.picker.git_status()<cr>",
      desc = "Open changed file",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gp",
      ":lua require 'gitsigns'.preview_hunk()<cr>",
      desc = "Preview Hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gr",
      ":lua require 'gitsigns'.reset_hunk()<cr>",
      desc = "Reset Hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gs",
      ":lua require 'gitsigns'.stage_hunk()<cr>",
      desc = "Stage Hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gu",
      ":lua require 'gitsigns'.undo_stage_hunk()<cr>",
      desc = "Undo Stage Hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gw",
      group = "Worktrees",
      nowait = true,
      remap = false,
    },
    {
      "<leader>p",
      group = "Projects",
      nowait = true,
      remap = false,
    },
    {
      "<leader>pp",
      function()
        PickProject()
      end,
      desc = "Open Project",
      nowait = true,
      remap = false,
    },
    {
      "<leader>q",
      group = "Quit",
      nowait = true,
      remap = false,
    },
    {
      "<leader>qQ",
      ":qa!<cr>",
      desc = "Quit Anyway (without saving)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>qq",
      ":qa<cr>",
      desc = "Quit Neovim",
      nowait = true,
      remap = false,
    },
    {
      "<leader>qa",
      ":xa<cr>",
      desc = "Quit Saving Everything",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ql",
      ":source ~/.local/share/nvim/session.vim<cr>",
      desc = "Load default session",
      nowait = true,
      remap = false,
    },
    {
      "<leader>qL",
      ":source ~/.local/share/nvim/sessions/$HOSTNAME/session.vim<cr>",
      desc = "Load host session",
      nowait = true,
      remap = false,
    },
    {
      "<leader>qw",
      ":mksession! ~/.local/share/nvim/session.vim<cr>",
      desc = "Save default session",
      nowait = true,
      remap = false,
    },
    {
      "<leader>h",
      group = "Help",
      nowait = true,
      remap = false,
    },
    {
      "<leader>hC",
      ":lua Snacks.picker.commands()<cr>",
      desc = "Commands",
      nowait = true,
      remap = false,
    },
    {
      "<leader>hH",
      ":lua Snacks.picker.highlights()<cr>",
      desc = "Highlight groups",
      nowait = true,
      remap = false,
    },
    {
      "<leader>hM",
      ":lua Snacks.picker.man()<cr>",
      desc = "Man Pages",
      nowait = true,
      remap = false,
    },
    {
      "<leader>hR",
      ":lua Snacks.picker.registers()<cr>",
      desc = "Registers",
      nowait = true,
      remap = false,
    },
    {
      "<leader>hc",
      ":lua Snacks.picker.colorschemes()<cr>",
      desc = "Colorscheme",
      nowait = true,
      remap = false,
    },
    {
      "<leader>hh",
      ":lua Snacks.picker.help()<cr>",
      desc = "Find Help",
      nowait = true,
      remap = false,
    },
    {
      "<leader>hk",
      ":lua Snacks.picker.keymaps()<cr>",
      desc = "Keymaps",
      nowait = true,
      remap = false,
    },
    {
      "<leader>hn",
      ":lua Snacks.notifier.show_history()<cr>",
      desc = "Notifications",
      nowait = true,
      remap = false,
    },
    {
      "<leader>s",
      group = "Search",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sg",
      ":lua Snacks.picker.grep()<cr>",
      desc = "Live Grep",
      nowait = true,
      remap = false,
    },
    {
      "<leader>w",
      group = "Windows",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wf",
      ":fc!<cr>",
      desc = "Close all floating windows",
      nowait = true,
      remap = false,
    },
    {
      "<leader>w-",
      "<C-w>_",
      desc = "Resize Horizontal Windows",
      nowait = true,
      remap = false,
    },
    {
      "<leader>w=",
      "<C-w>=",
      desc = "Balance Window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wc",
      "<C-w>c",
      desc = "Close Window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wh",
      "<C-w>h",
      desc = "Window Left",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wj",
      "<C-w>j",
      desc = "Window Below",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wk",
      "<C-w>k",
      desc = "Window Up",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wl",
      "<C-w>l",
      desc = "Window Right",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wm",
      "<C-w>o",
      desc = "Maximize window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wp",
      "<C-w>p",
      desc = "Previous Window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wV",
      "<C-w>s",
      desc = "Split Window Horizontally",
      nowait = true,
      remap = false,
    },
    {
      "<leader>wH",
      "<C-w>v",
      desc = "Split Window Vertically",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ww",
      "<C-w><C-w>",
      desc = "Switch Window",
      nowait = true,
      remap = false,
    },
    {
      "<leader>w|",
      "<C-w>|",
      desc = "Resize Vertical Windows",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ws",
      ":call WindowSwap#EasyWindowSwap()<cr>",
      desc = "Swap Windows",
      nowait = true,
      remap = false,
    },
  },
}
which_key.setup(options)

if ok_hop then
  local directions = require("hop.hint").HintDirection
  local specs = {
    mode = { "n", "v" },
    {
      "gs",
      group = "Hop (Easymotion)",
      nowait = true,
      remap = false,
    },
    {
      "gsF",
      function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false,
    },
    {
      "gsJ",
      function()
        hop.hint_lines_skip_whitespace({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Search word forwards",
      nowait = true,
      remap = false,
    },
    {
      "gsK",
      function()
        hop.hint_lines_skip_whitespace({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false,
    },
    {
      "gsS",
      function()
        hop.hint_char2({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false,
    },
    {
      "gsf",
      function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Search word forwards",
      nowait = true,
      remap = false,
    },
    {
      "gsj",
      function()
        hop.hint_lines({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Search word forwards",
      nowait = true,
      remap = false,
    },
    {
      "gsk",
      function()
        hop.hint_lines({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false,
    },
    {
      "gss",
      function()
        hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Search word forwards",
      nowait = true,
      remap = false,
    },
  }

  which_key.add(specs)
end

local specs = {
  mode = { "v" },
  { "<leader>", group = "Text", nowait = true, remap = false },
  { "<leader>s", ":sort<cr>", desc = "Sort", nowait = true, remap = false },
  { "<leader>S", ":sort i<cr>", desc = "Sort (Case Insensitive)", nowait = true, remap = false },
  { "<leader>u", ":!uniq <cr>", desc = "Unique", nowait = true, remap = false },
}

which_key.add(specs)
