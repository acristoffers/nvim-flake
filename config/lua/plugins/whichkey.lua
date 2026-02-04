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
      desc = "Org",
      nowait = true,
      remap = false,
    },
    {
      "<leader>b",
      group = "Buffers",
      desc = "Buffers",
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
      desc = "Close",
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
      desc = "Sort",
      nowait = true,
      remap = false,
    },
    { "<leader>c",  group = "Code",                           desc = "Code",                    nowait = true, remap = false },
    { "<leader>cc", ":CodeCompanionChat Toggle<cr>",          desc = "Toggle LLM",              nowait = true, remap = false },
    { "<leader>ch", ":LspClangdSwitchSourceHeader<cr>",       desc = "Switch .h/.cpp",          nowait = true, remap = false },
    { "<leader>ct", ":Trim<cr>",                              desc = "Trim trailling spaces",   nowait = true, remap = false },
    { "<leader>cf", ":Format<cr>",                            desc = "Format (formatter.nvim)", nowait = true, remap = false },
    { '<leader>co', function() require('codex').toggle() end, desc = 'Toggle Codex',            nowait = true, remap = false },
    { "<leader>d",  group = "Debug",                          desc = "Debug",                   nowait = true, remap = false },
    { "<leader>du", function() require 'dapui'.toggle() end,  desc = "Toggle UI",               nowait = true, remap = false },
    {
      "<leader>da",
      function()
        local dap = require("dap")
        local ft = vim.bo.filetype
        local configs = dap.configurations[ft]
        if not configs then
          vim.notify("No DAP configurations for filetype: " .. ft, vim.log.levels.WARN)
          return
        end
        vim.ui.select(
          configs,
          {
            prompt = "Select config:",
            format_item = function(config) return config.name end
          },
          function(config)
            if config then
              dap.run(config)
            end
          end
        )
      end,
      desc = "Run: Select Configuration",
      mode = { "n", "x" },
      nowait = true,
      remap = false
    },
    { "<leader>de",  function() require("dapui").eval() end,                                                      desc = "Eval",                                               mode = { "n", "x" }, nowait = true, remap = false },
    { "<leader>dw",  function() require("dap.ui.widgets").hover() end,                                            desc = "Hover Widget",                                       nowait = true,       remap = false },
    { "<leader>dS",  function() require("dapui").float_element("stacks", { enter = true }) end,                   desc = "Backtrace (Stacks)",                                 nowait = true,       remap = false },
    { "<leader>dc",  function() require("dap").continue() end,                                                    desc = "Run / Continue",                                     nowait = true,       remap = false },
    { "<leader>dr",  function() require("dap").run_last() end,                                                    desc = "Run Last",                                           nowait = true,       remap = false },
    { "<leader>dq",  function() require("dap").terminate() end,                                                   desc = "Stop: Terminate",                                    nowait = true,       remap = false },
    { "<leader>dD",  function() require("dap").disconnect() end,                                                  desc = "Stop: Disconnect",                                   nowait = true,       remap = false },
    { "<leader>dp",  function() require("dap").pause() end,                                                       desc = "Pause",                                              nowait = true,       remap = false },
    { "<leader>dC",  function() require("dap").run_to_cursor() end,                                               desc = "Run to Cursor",                                      nowait = true,       remap = false },
    { "<leader>dg",  function() require("dap").goto_() end,                                                       desc = "Go to Line (No Execute)",                            nowait = true,       remap = false },
    { "<leader>dn",  function() require("dap").step_over() end,                                                   desc = "Step Over",                                          nowait = true,       remap = false },
    { "<leader>di",  function() require("dap").step_into() end,                                                   desc = "Step Into",                                          nowait = true,       remap = false },
    { "<leader>do",  function() require("dap").step_out() end,                                                    desc = "Step Out / Finish Function",                         nowait = true,       remap = false },
    { "<leader>dj",  function() require("dap").down() end,                                                        desc = "Down (Stack Frame)",                                 nowait = true,       remap = false },
    { "<leader>dk",  function() require("dap").up() end,                                                          desc = "Up (Stack Frame)",                                   nowait = true,       remap = false },
    { "<leader>dR",  function() require("dap").repl.toggle() end,                                                 desc = "Toggle REPL",                                        nowait = true,       remap = false },
    { "<leader>ds",  function() require("dap").session() end,                                                     desc = "Session",                                            nowait = true,       remap = false },
    { "<leader>db",  group = "Breakpoints",                                                                       desc = "Breakpoints",                                        nowait = true,       remap = false },
    { "<leader>dt",  function() require("dap").toggle_breakpoint() end,                                           desc = "Toggle Breakpoint",                                  nowait = true,       remap = false },
    { "<leader>dbB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,        desc = "Conditional Breakpoint",                             nowait = true,       remap = false },
    { "<leader>dbL", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Log Point",                                          nowait = true,       remap = false },
    { "<leader>dbC", function() require("dap").clear_breakpoints() end,                                           desc = "Clear All Breakpoints",                              nowait = true,       remap = false },
    { "<leader>dbu", function() require("dapui").float_element("breakpoints", { enter = true }) end,              desc = "UI: Breakpoints List (toggle enable/disable there)", nowait = true,       remap = false },
    { "<leader>l",   group = "LSP",                                                                               desc = "LSP",                                                nowait = true,       remap = false },
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
      desc = "Toggle",
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
      "<leader>tm",
      ":Markview<CR>",
      desc = "Markdown preview",
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
      desc = "File",
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
      ":e /home/alan/.org/finances/2026.ledger<cr>",
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
      desc = "Git",
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
      ":lua require 'gitsigns'.blame_line({full=true})<cr>",
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
      desc = "Worktrees",
      nowait = true,
      remap = false,
    },
    {
      "<leader>p",
      group = "Projects",
      desc = "Projects",
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
      desc = "Quit",
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
      desc = "Help",
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
      desc = "Search",
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
      desc = "Windows",
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
      desc = "Hop (Easymotion)",
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
  { "<leader>",  group = "Text", desc = "Text",                    nowait = true, remap = false },
  { "<leader>s", ":sort<cr>",    desc = "Sort",                    nowait = true, remap = false },
  { "<leader>S", ":sort i<cr>",  desc = "Sort (Case Insensitive)", nowait = true, remap = false },
  { "<leader>u", ":!uniq <cr>",  desc = "Unique",                  nowait = true, remap = false },
}

which_key.add(specs)
