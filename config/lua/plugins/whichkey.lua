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
  triggers = {
    { "<auto>", mode = "nixsotc" },
    { "m", mode = { "n" } },
    { "s", mode = { "n" } },
  },
  spec = {
    nowait = true,
    remap = false,
    { "<leader> ", ":lua Snacks.picker.files()<cr>", desc = "Find File" },
    { "<leader>o", group = "Org" },
    { "<leader>b", group = "Buffers" },
    { "<leader>bb", ":lua Snacks.picker.buffers()<cr>", desc = "Go to Buffer (Picker)" },
    { "<leader>bc", group = "Close" },
    { "<leader>bo", ":lua Snacks.bufdelete.other()<cr>", desc = "Close Others" },
    { "<leader>bK", ":bd!<cr>", desc = "Force Close Buffer" },
    { "<leader>bk", ":bd<cr>", desc = "Close Buffer" },
    { "<leader>bn", ":bn<cr>", desc = "Next" },
    { "<leader>bp", ":bp<cr>", desc = "Previous" },
    { "<leader>br", ":e!<cr>", desc = "Reload current buffer" },
    { "<leader>bs", group = "Sort" },
    { "<leader>c", group = "Code" },
    { "<leader>cc", ":CodeCompanionChat Toggle<cr>", desc = "Toggle LLM" },
    { "<leader>ch", ":LspClangdSwitchSourceHeader<cr>", desc = "Switch .h/.cpp" },
    { "<leader>ct", ":Trim<cr>", desc = "Trim trailling spaces" },
    { "<leader>cf", ":Format<cr>", desc = "Format (formatter.nvim)" },
    {
      "<leader>co",
      function()
        require("codex").toggle()
      end,
      desc = "Toggle Codex",
    },
    { "<leader>d", group = "Debug" },
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle UI",
    },
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
        vim.ui.select(configs, {
          prompt = "Select config:",
          format_item = function(config)
            return config.name
          end,
        }, function(config)
          if config then
            dap.run(config)
          end
        end)
      end,
      desc = "Run: Select Configuration",
      mode = { "n", "x" },
    },
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      desc = "Eval",
      mode = { "n", "x" },
    },
    {
      "<leader>dw",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Hover Widget",
    },
    {
      "<leader>dS",
      function()
        require("dapui").float_element("stacks", { enter = true })
      end,
      desc = "Backtrace (Stacks)",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Run / Continue",
    },
    {
      "<leader>dr",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>dq",
      function()
        require("dap").terminate()
      end,
      desc = "Stop: Terminate",
    },
    {
      "<leader>dD",
      function()
        require("dap").disconnect()
      end,
      desc = "Stop: Disconnect",
    },
    {
      "<leader>dp",
      function()
        require("dap").pause()
      end,
      desc = "Pause",
    },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<leader>dg",
      function()
        require("dap").goto_()
      end,
      desc = "Go to Line (No Execute)",
    },
    {
      "<leader>dn",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out / Finish Function",
    },
    {
      "<leader>dj",
      function()
        require("dap").down()
      end,
      desc = "Down (Stack Frame)",
    },
    {
      "<leader>dk",
      function()
        require("dap").up()
      end,
      desc = "Up (Stack Frame)",
    },
    {
      "<leader>dR",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>ds",
      function()
        require("dap").session()
      end,
      desc = "Session",
    },
    { "<leader>db", group = "Breakpoints" },
    {
      "<leader>dt",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dbB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Conditional Breakpoint",
    },
    {
      "<leader>dbL",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end,
      desc = "Log Point",
    },
    {
      "<leader>dbC",
      function()
        require("dap").clear_breakpoints()
      end,
      desc = "Clear All Breakpoints",
    },
    {
      "<leader>dbu",
      function()
        require("dapui").float_element("breakpoints", { enter = true })
      end,
      desc = "UI: Breakpoints List (toggle enable/disable there)",
    },
    { "<leader>l", group = "LSP" },
    { "<leader>la", ":lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    { "<leader>lA", GetCodeActionsAndApplyGlobally, desc = "Code Action (Apply in buffer)" },
    {
      "<leader>ld",
      ":lua Snacks.picker.diagnostics_buffer()<cr>",
      desc = "Diagnostics (Buffer)",
    },
    { "<leader>lD", ":lua Snacks.picker.diagnostics()<cr>", desc = "Diagnostics (Workspace)" },
    { "<leader>lf", ":lua vim.lsp.buf.format()<cr>", desc = "Format (LSP)" },
    { "<leader>li", ":LspInfo<cr>", desc = "Info" },
    { "<leader>lI", ":LspInstallInfo<cr>", desc = "Installer Info" },
    {
      "<leader>lj",
      function()
        vim.diagnostic.jump({ count = 1, float = true })
      end,
      desc = "Next Diagnostic",
    },
    {
      "<leader>lk",
      function()
        vim.diagnostic.jump({ count = -1, float = true })
      end,
      desc = "Prev Diagnostic",
    },
    { "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
    { "<leader>lo", vim.diagnostic.open_float, desc = "Open Float" },
    { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
    { "<leader>lQ", ":lua Snacks.picker.loclist()<cr>", desc = "Quickfix (Picker)" },
    { "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
    { "<leader>ls", ":lua Snacks.picker.lsp_symbols()<cr>", desc = "Document Symbols" },
    {
      "<leader>lS",
      ":lua Snacks.picker.lsp_workspace_symbols()<cr>",
      desc = "Workspace Symbols",
    },
    { "<leader>t", group = "Toggle" },
    { "<leader>te", ":lua Snacks.explorer()<CR>", desc = "File Tree" },
    {
      "<leader>tf",
      function()
        ---@diagnostic disable-next-line: undefined-field
        if vim.opt_local.foldmethod:get() == "expr" then
          vim.opt_local.foldmethod = "manual"
        else
          vim.opt_local.foldmethod = "expr"
        end
        vim.cmd([[ help fdm ]])
        vim.cmd([[ helpclose ]])
      end,
      desc = "Fold method",
    },
    {
      "<leader>ti",
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      desc = "Inlay Hints",
    },
    { "<leader>tu", ":UndotreeToggle<cr>", desc = "Undo Tree" },
    { "<leader>tc", ":ColorizerToggle<cr>", desc = "Colorizer" },
    { "<leader>tm", ":Markview<CR>", desc = "Markdown preview" },
    { "<leader>th", ":nohlsearch<cr>", desc = "Highlight" },
    { "<leader>ts", group = "Spell" },
    { "<leader>tse", ":set spell<cr>", desc = "Enable" },
    { "<leader>tsd", ":set nospell<cr>", desc = "Disable" },
    { "<leader>tsl", group = "Languages" },
    { "<leader>tsle", ":set spell spelllang=en<cr>", desc = "English" },
    { "<leader>tsld", ":set spell spelllang=de<cr>", desc = "Deutsch" },
    { "<leader>tsls", ":set spell spelllang=es<cr>", desc = "Espanhol" },
    { "<leader>tslf", ":set spell spelllang=fr<cr>", desc = "Français" },
    { "<leader>tsli", ":set spell spelllang=it<cr>", desc = "Italiano" },
    { "<leader>tslp", ":set spell spelllang=pt_br<cr>", desc = "Português" },
    { "<leader>f", group = "File" },
    { "<leader>fa", ":silent wa<cr>", desc = "Save All" },
    { "<leader>fw", SaveNormalizedUTF8, desc = "Save File (Fix Encoding)" },
    { "<leader>fg", ":lua Snacks.picker.git_files()<cr>", desc = "Find Git File" },
    { "<leader>fh", ":wshada!<cr>", desc = "Save shada (fixes overpersistent marks)" },
    { "<leader>fL", ":e /home/alan/.org/finances/2026.ledger<cr>", desc = "Open Ledger" },
    { "<leader>fn", ":ene!<cr>", desc = "New file" },
    { "<leader>fo", ":lua Snacks.picker.files()<cr>", desc = "Open File" },
    { "<leader>fr", ":lua Snacks.picker.recent()<CR>", desc = "Recent File" },
    { "<leader>fS", ":silent noa w<cr>", desc = "Save File (no autocommands)" },
    { "<leader>fs", ":silent w<cr>", desc = "Save File" },
    { "<leader>g", group = "Git" },
    { "<leader>gR", ":lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
    { "<leader>gb", ":lua Snacks.picker.git_branches()<cr>", desc = "Checkout branch" },
    { "<leader>gc", ":GitConflictRefresh<cr>", desc = "Git Conflict Refresh" },
    { "<leader>gd", ":Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
    { "<leader>gg", require("neogit").open, desc = "Neogit" },
    {
      "<leader>gh",
      ":AdvancedGitSearch search_log_content_file<cr>",
      desc = "Wayback Machine (History)",
    },
    { "<leader>gj", ":lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk" },
    { "<leader>gk", ":lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk" },
    { "<leader>gl", ":lua require 'gitsigns'.blame_line({full=true})<cr>", desc = "Blame" },
    { "<leader>go", ":lua Snacks.picker.git_status()<cr>", desc = "Open changed file" },
    { "<leader>gp", ":lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
    { "<leader>gr", ":lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
    { "<leader>gs", ":lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
    { "<leader>gu", ":lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
    { "<leader>gw", group = "Worktrees" },
    { "<leader>p", group = "Projects" },
    {
      "<leader>pp",
      function()
        PickProject()
      end,
      desc = "Open Project",
    },
    { "<leader>q", group = "Quit" },
    { "<leader>qQ", ":qa!<cr>", desc = "Quit Anyway (without saving)" },
    { "<leader>qq", ":qa<cr>", desc = "Quit Neovim" },
    { "<leader>qa", ":xa<cr>", desc = "Quit Saving Everything" },
    {
      "<leader>ql",
      ":source ~/.local/share/nvim/session.vim<cr>",
      desc = "Load default session",
    },
    {
      "<leader>qL",
      ":source ~/.local/share/nvim/sessions/$HOSTNAME/session.vim<cr>",
      desc = "Load host session",
    },
    {
      "<leader>qw",
      ":mksession! ~/.local/share/nvim/session.vim<cr>",
      desc = "Save default session",
    },
    { "<leader>h", group = "Help" },
    { "<leader>hC", ":lua Snacks.picker.commands()<cr>", desc = "Commands" },
    { "<leader>hH", ":lua Snacks.picker.highlights()<cr>", desc = "Highlight groups" },
    { "<leader>hM", ":lua Snacks.picker.man()<cr>", desc = "Man Pages" },
    { "<leader>hR", ":lua Snacks.picker.registers()<cr>", desc = "Registers" },
    { "<leader>hc", ":lua Snacks.picker.colorschemes()<cr>", desc = "Colorscheme" },
    { "<leader>hh", ":lua Snacks.picker.help()<cr>", desc = "Find Help" },
    { "<leader>hk", ":lua Snacks.picker.keymaps()<cr>", desc = "Keymaps" },
    { "<leader>hn", ":lua Snacks.notifier.show_history()<cr>", desc = "Notifications" },
    { "<leader>s", group = "Search" },
    { "<leader>sg", ":lua Snacks.picker.grep()<cr>", desc = "Live Grep" },
    { "<leader>w", group = "Windows" },
    { "<leader>wf", ":fc!<cr>", desc = "Close all floating windows" },
    { "<leader>w-", "<C-w>_", desc = "Resize Horizontal Windows" },
    { "<leader>w=", "<C-w>=", desc = "Balance Window" },
    { "<leader>wc", "<C-w>c", desc = "Close Window" },
    { "<leader>wh", "<C-w>h", desc = "Window Left" },
    { "<leader>wj", "<C-w>j", desc = "Window Below" },
    { "<leader>wk", "<C-w>k", desc = "Window Up" },
    { "<leader>wl", "<C-w>l", desc = "Window Right" },
    { "<leader>wm", "<C-w>o", desc = "Maximize window" },
    { "<leader>wp", "<C-w>p", desc = "Previous Window" },
    { "<leader>wV", "<C-w>s", desc = "Split Window Horizontally" },
    { "<leader>wH", "<C-w>v", desc = "Split Window Vertically" },
    { "<leader>ww", "<C-w><C-w>", desc = "Switch Window" },
    { "<leader>w|", "<C-w>|", desc = "Resize Vertical Windows" },
    { "<leader>ws", ":call WindowSwap#EasyWindowSwap()<cr>", desc = "Swap Windows" },
  },
}
which_key.setup(options)

if ok_hop then
  local directions = require("hop.hint").HintDirection
  local specs = {
    mode = { "n", "v" },
    nowait = true,
    remap = false,
    { "gs", group = "Hop (Easymotion)" },
    {
      "gsF",
      function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end,
      desc = "Search word backwards",
    },
    {
      "gsJ",
      function()
        hop.hint_lines_skip_whitespace({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Search word forwards",
    },
    {
      "gsK",
      function()
        hop.hint_lines_skip_whitespace({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end,
      desc = "Search word backwards",
    },
    {
      "gsS",
      function()
        hop.hint_char2({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end,
      desc = "Search word backwards",
    },
    {
      "gsf",
      function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Search word forwards",
    },
    {
      "gsj",
      function()
        hop.hint_lines({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Search word forwards",
    },
    {
      "gsk",
      function()
        hop.hint_lines({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end,
      desc = "Search word backwards",
    },
    {
      "gss",
      function()
        hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Search word forwards",
    },
  }

  which_key.add(specs)
end

which_key.add({
  mode = { "v" },
  nowait = true,
  remap = false,
  { "<leader>", group = "Text" },
  { "<leader>s", ":sort<cr>", desc = "Sort" },
  { "<leader>S", ":sort i<cr>", desc = "Sort (Case Insensitive)" },
  { "<leader>u", ":!uniq <cr>", desc = "Unique" },
})

which_key.add({
  mode = { "n" },
  nowait = true,
  remap = false,
  { "gl", group = "GitLab" },
  { "glt", group = "Templates" },
})

local marks_ok, marks = pcall(require, "marks")
if marks_ok then
  local function delete_mark(mark)
    if require("marks.utils").is_valid_mark(mark) then
      marks.mark_state:delete_mark(mark)
    end
  end
  local function delete_mark_f(mark)
    return function()
      delete_mark(mark)
    end
  end
  local mappings = {
    mode = "n",
    nowait = true,
    remap = false,
    { "m", group = "Marks" },
    { "dm", group = "Marks" },
    { "m,", marks.set_next, desc = "Set next" },
    { "m;", marks.toggle, desc = "Toggle" },
    { "m]", marks.next, desc = "Go to next mark" },
    { "m[", marks.prev, desc = "Go to previous mark" },
    { "m:", marks.preview, desc = "Preview" },
    { "m}", marks.next_bookmark, desc = "Go to next bookmark" },
    { "m{", marks.prev_bookmark, desc = "Go to previous bookmark" },
    { "dm-", marks.delete_line, desc = "Delete marks in line" },
    { "dm=", marks.delete_bookmark, desc = "Delete bookmarks in line" },
    { "dm<space>", marks.delete_buf, desc = "Delete all marks in buffer" },
  }
  local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  for i = 1, #alphabet do
    local letter = alphabet:sub(i, i)
    table.insert(mappings, { "m" .. letter, "m" .. letter, desc = "Set Mark " .. letter, hidden = true })
    table.insert(mappings, { "dm" .. letter, delete_mark_f(letter), desc = "Delete Mark " .. letter, hidden = true })
    letter = letter:lower()
    table.insert(mappings, { "m" .. letter, "m" .. letter, desc = "Set Mark " .. letter, hidden = true })
    table.insert(mappings, { "dm" .. letter, delete_mark_f(letter), desc = "Delete Mark " .. letter, hidden = true })
  end
  for i = 0, 9 do
    table.insert(mappings, { "m" .. i, marks["set_bookmark" .. i], desc = "Set Bookmark " .. i, hidden = true })
    table.insert(mappings, { "dm" .. i, marks["delete_bookmark" .. i], desc = "Delete Bookmark " .. i, hidden = true })
  end
  which_key.add(mappings)
end
