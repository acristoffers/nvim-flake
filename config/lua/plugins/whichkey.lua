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

local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a)
      return a.isPreferred
    end,
    apply = true,
  })
end

local options = {
  preset = "modern",
  delay = 200,
  spec = {
    { "<leader> ",   ":lua require'telescope.builtin'.find_files()<cr>",                           desc = "Find File",                               nowait = true, remap = false },
    { "<leader>;",   ":Alpha<cr>",                                                                 desc = "Dashboard",                               nowait = true, remap = false },
    { "<leader>T",   group = "Treesitter",                                                         nowait = true,                                    remap = false },
    { "<leader>Ti",  ":Inspect<cr>",                                                               desc = "Inspect",                                 nowait = true, remap = false },
    { "<leader>Tt",  ":InspectTree<cr>",                                                           desc = "Inspect Tree",                            nowait = true, remap = false },
    { "<leader>b",   group = "Buffers",                                                            nowait = true,                                    remap = false },
    { "<leader>bB",  ":Telescope buffers<cr>",                                                     desc = "Go to Buffer (Telescope)",                nowait = true, remap = false },
    { "<leader>bD",  ":BufferLineSortByDirectory<cr>",                                             desc = "Sort by directory",                       nowait = true, remap = false },
    { "<leader>bK",  ":bd!<cr>",                                                                   desc = "Force Close Buffer",                      nowait = true, remap = false },
    { "<leader>bL",  ":BufferLineSortByExtension<cr>",                                             desc = "Sort by language",                        nowait = true, remap = false },
    { "<leader>bb",  ":BufferLinePick<cr>",                                                        desc = "Go to Buffer (BufferLine)",               nowait = true, remap = false },
    { "<leader>be",  ":BufferLinePickClose<cr>",                                                   desc = "Pick which buffer to close",              nowait = true, remap = false },
    { "<leader>bh",  ":BufferLineCloseLeft<cr>",                                                   desc = "Close all to the left",                   nowait = true, remap = false },
    { "<leader>bk",  ":bd<cr>",                                                                    desc = "Close Buffer",                            nowait = true, remap = false },
    { "<leader>bl",  ":BufferLineCloseRight<cr>",                                                  desc = "Close all to the right",                  nowait = true, remap = false },
    { "<leader>bn",  ":BufferLineCycleNext<cr>",                                                   desc = "Next",                                    nowait = true, remap = false },
    { "<leader>bo",  ":BufferLineCloseRight<cr><cmd>BufferLineCloseLeft<cr>",                      desc = "Close Others",                            nowait = true, remap = false },
    { "<leader>bp",  ":BufferLineCyclePrev<cr>",                                                   desc = "Previous",                                nowait = true, remap = false },
    { "<leader>br",  ":e!<cr>",                                                                    desc = "Reload current buffer",                   nowait = true, remap = false },
    { "<leader>c",   group = "Code",                                                               nowait = true,                                    remap = false },
    { "<leader>cA",  GetCodeActionsAndApplyGlobally,                                               desc = "Code Action (Apply in buffer)",           nowait = true, remap = false },
    { "<leader>cI",  ":LspInstallInfo<cr>",                                                        desc = "Installer Info",                          nowait = true, remap = false },
    { "<leader>cS",  ":Telescope lsp_dynamic_workspace_symbols<cr>",                               desc = "Workspace Symbols",                       nowait = true, remap = false },
    { "<leader>ca",  ":lua vim.lsp.buf.code_action()<cr>",                                         desc = "Code Action",                             nowait = true, remap = false },
    { "<leader>cc",  ":TextCaseOpenTelescope<cr>",                                                 desc = "Change Case",                             nowait = true, remap = false },
    { "<leader>cd",  ":Telescope diagnostics bufnr=0 theme=get_ivy<cr>",                           desc = "Buffer Diagnostics",                      nowait = true, remap = false },
    { "<leader>ce",  ":Telescope quickfix<cr>",                                                    desc = "Telescope Quickfix",                      nowait = true, remap = false },
    { "<leader>cgp", ":ChatGPT<cr>",                                                               desc = "ChatGPT Prompt",                          nowait = true, remap = false },
    { "<leader>cge", ":ChatGPTEditWithInstructions<cr>",                                           desc = "Edit With Instructions",                  nowait = true, remap = false, mode = "v" },
    { "<leader>cf",  ":Format<cr>",                                                                desc = "Format",                                  nowait = true, remap = false },
    { "<leader>ch",  ":Ouroboros<cr>",                                                             desc = "Switch .h/.cpp",                          nowait = true, remap = false },
    { "<leader>ci",  ":LspInfo<cr>",                                                               desc = "Info",                                    nowait = true, remap = false },
    { "<leader>cj",  vim.diagnostic.goto_next,                                                     desc = "Next Diagnostic",                         nowait = true, remap = false },
    { "<leader>ck",  vim.diagnostic.goto_prev,                                                     desc = "Prev Diagnostic",                         nowait = true, remap = false },
    { "<leader>cl",  vim.lsp.codelens.run,                                                         desc = "CodeLens Action",                         nowait = true, remap = false },
    { "<leader>cq",  quickfix,                                                                     desc = "Quickfix",                                nowait = true, remap = false },
    { "<leader>cr",  vim.lsp.buf.rename,                                                           desc = "Rename",                                  nowait = true, remap = false },
    { "<leader>cs",  ":Telescope lsp_document_symbols<cr>",                                        desc = "Document Symbols",                        nowait = true, remap = false },
    { "<leader>cw",  ":Telescope diagnostics<cr>",                                                 desc = "Diagnostics",                             nowait = true, remap = false },
    { "<leader>e",   ":NvimTreeToggle<CR>",                                                        desc = "Toggle File Tree",                        nowait = true, remap = false },
    { "<leader>f",   group = "File",                                                               nowait = true,                                    remap = false },
    { "<leader>fS",  ":silent noa w<cr>",                                                          desc = "Save File (no autocommands)",             nowait = true, remap = false },
    { "<leader>fa",  ":silent wa<cr>",                                                             desc = "Save All",                                nowait = true, remap = false },
    { "<leader>ff",  SaveNormalizedUTF8,                                                           desc = "Save File (Fix Encoding)",                nowait = true, remap = false },
    { "<leader>fg",  ":lua require'telescope.builtin'.git_files()<cr>",                            desc = "Find Git File",                           nowait = true, remap = false },
    { "<leader>fh",  ":wshada!<cr>",                                                               desc = "Save shada (fixes overpersistent marks)", nowait = true, remap = false },
    { "<leader>fl",  ":e /home/alan/.org/finances/2024.ledger<cr>",                                desc = "Open Ledger Journal",                     nowait = true, remap = false },
    { "<leader>fn",  ":ene!<cr>",                                                                  desc = "New file",                                nowait = true, remap = false },
    { "<leader>fo",  ":lua require'telescope.builtin'.find_files()<cr>",                           desc = "Find File",                               nowait = true, remap = false },
    { "<leader>fs",  ":silent w<cr>",                                                              desc = "Save File",                               nowait = true, remap = false },
    { "<leader>fw",  ":Trim<cr>",                                                                  desc = "Remove trailling spaces",                 nowait = true, remap = false },
    { "<leader>g",   group = "Git",                                                                nowait = true,                                    remap = false },
    { "<leader>gC",  ":Telescope git_bcommits<cr>",                                                desc = "Checkout commit(for current file)",       nowait = true, remap = false },
    { "<leader>gR",  ":lua require 'gitsigns'.reset_buffer()<cr>",                                 desc = "Reset Buffer",                            nowait = true, remap = false },
    { "<leader>gb",  ":Telescope git_branches<cr>",                                                desc = "Checkout branch",                         nowait = true, remap = false },
    { "<leader>gc",  ":Telescope git_commits<cr>",                                                 desc = "Checkout commit",                         nowait = true, remap = false },
    { "<leader>gd",  ":Gitsigns diffthis HEAD<cr>",                                                desc = "Git Diff",                                nowait = true, remap = false },
    { "<leader>gg",  require("neogit").open,                                                       desc = "Neogit",                                  nowait = true, remap = false },
    { "<leader>gh",  require("telescope").extensions.git_file_history.git_file_history,            desc = "Wayback Machine (History)",               nowait = true, remap = false },
    { "<leader>gj",  ":lua require 'gitsigns'.next_hunk()<cr>",                                    desc = "Next Hunk",                               nowait = true, remap = false },
    { "<leader>gk",  ":lua require 'gitsigns'.prev_hunk()<cr>",                                    desc = "Prev Hunk",                               nowait = true, remap = false },
    { "<leader>gl",  ":lua require 'gitsigns'.blame_line()<cr>",                                   desc = "Blame",                                   nowait = true, remap = false },
    { "<leader>go",  ":Telescope git_status<cr>",                                                  desc = "Open changed file",                       nowait = true, remap = false },
    { "<leader>gp",  ":lua require 'gitsigns'.preview_hunk()<cr>",                                 desc = "Preview Hunk",                            nowait = true, remap = false },
    { "<leader>gr",  ":lua require 'gitsigns'.reset_hunk()<cr>",                                   desc = "Reset Hunk",                              nowait = true, remap = false },
    { "<leader>gs",  ":lua require 'gitsigns'.stage_hunk()<cr>",                                   desc = "Stage Hunk",                              nowait = true, remap = false },
    { "<leader>gu",  ":lua require 'gitsigns'.undo_stage_hunk()<cr>",                              desc = "Undo Stage Hunk",                         nowait = true, remap = false },
    { "<leader>gw",  group = "Worktrees",                                                          nowait = true,                                    remap = false },
    { "<leader>gwa", require("telescope").extensions.git_worktree.create_git_worktree,             desc = "Add",                                     nowait = true, remap = false },
    { "<leader>gwl", require("telescope").extensions.git_worktree.git_worktrees,                   desc = "List",                                    nowait = true, remap = false },
    { "<leader>h",   group = "Help",                                                               nowait = true,                                    remap = false },
    { "<leader>hk",  ":Telescope keymaps<cr>",                                                     desc = "Keymaps",                                 nowait = true, remap = false },
    { "<leader>l",   group = "LSP",                                                                nowait = true,                                    remap = false },
    { "<leader>lI",  ":LspInstallInfo<cr>",                                                        desc = "Installer Info",                          nowait = true, remap = false },
    { "<leader>lS",  ":Telescope lsp_dynamic_workspace_symbols<cr>",                               desc = "Workspace Symbols",                       nowait = true, remap = false },
    { "<leader>la",  ":lua vim.lsp.buf.code_action()<cr>",                                         desc = "Code Action",                             nowait = true, remap = false },
    { "<leader>ld",  ":Telescope diagnostics bufnr=0 theme=get_ivy<cr>",                           desc = "Buffer Diagnostics",                      nowait = true, remap = false },
    { "<leader>le",  ":Telescope quickfix<cr>",                                                    desc = "Telescope Quickfix",                      nowait = true, remap = false },
    { "<leader>lf",  ":lua vim.lsp.buf.format()<cr>",                                              desc = "Format",                                  nowait = true, remap = false },
    { "<leader>li",  ":LspInfo<cr>",                                                               desc = "Info",                                    nowait = true, remap = false },
    { "<leader>lj",  vim.diagnostic.goto_next,                                                     desc = "Next Diagnostic",                         nowait = true, remap = false },
    { "<leader>lk",  vim.diagnostic.goto_prev,                                                     desc = "Prev Diagnostic",                         nowait = true, remap = false },
    { "<leader>ll",  vim.lsp.codelens.run,                                                         desc = "CodeLens Action",                         nowait = true, remap = false },
    { "<leader>lo",  vim.diagnostic.open_float,                                                    desc = "Open Float",                              nowait = true, remap = false },
    { "<leader>lq",  vim.diagnostic.setloclist,                                                    desc = "Quickfix",                                nowait = true, remap = false },
    { "<leader>lr",  vim.lsp.buf.rename,                                                           desc = "Rename",                                  nowait = true, remap = false },
    { "<leader>ls",  ":Telescope lsp_document_symbols<cr>",                                        desc = "Document Symbols",                        nowait = true, remap = false },
    { "<leader>lw",  ":Telescope diagnostics<cr>",                                                 desc = "Diagnostics",                             nowait = true, remap = false },
    { "<leader>p",   group = "Projects",                                                           nowait = true,                                    remap = false },
    { "<leader>pp",  function() require("telescope").extensions.projects.projects({}) end,         desc = "Open Project",                            nowait = true, remap = false },
    { "<leader>q",   group = "Quit",                                                               nowait = true,                                    remap = false },
    { "<leader>qQ",  ":qa!<cr>",                                                                   desc = "Quit Anyway (without saving)",            nowait = true, remap = false },
    { "<leader>qq",  ":qa<cr>",                                                                    desc = "Quit Neovim",                             nowait = true, remap = false },
    { "<leader>qw",  ":xa<cr>",                                                                    desc = "Quit Saving Everything",                  nowait = true, remap = false },
    { "<leader>s",   group = "Search",                                                             nowait = true,                                    remap = false },
    { "<leader>sC",  ":Telescope commands<cr>",                                                    desc = "Commands",                                nowait = true, remap = false },
    { "<leader>sH",  ":Telescope highlights<cr>",                                                  desc = "Find highlight groups",                   nowait = true, remap = false },
    { "<leader>sM",  ":Telescope man_pages<cr>",                                                   desc = "Man Pages",                               nowait = true, remap = false },
    { "<leader>sP",  ':lua require"telescope.builtin".live_grep {cwd="~/.config/nvim"}<cr>',       desc = "Live Grep Config",                        nowait = true, remap = false },
    { "<leader>sR",  ":Telescope registers<cr>",                                                   desc = "Registers",                               nowait = true, remap = false },
    { "<leader>sT",  ":lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", desc = "Colorscheme with Preview",                nowait = true, remap = false },
    { "<leader>sb",  ":Telescope git_branches<cr>",                                                desc = "Checkout branch",                         nowait = true, remap = false },
    { "<leader>sc",  ":nohlsearch<cr>",                                                            desc = "No Highlight",                            nowait = true, remap = false },
    { "<leader>sf",  ":Telescope find_files<cr>",                                                  desc = "Find File",                               nowait = true, remap = false },
    { "<leader>sh",  ":Telescope help_tags<cr>",                                                   desc = "Find Help",                               nowait = true, remap = false },
    {
      "<leader>si",
      function()
        local luasnip_ok, luasnip = pcall(require, "luasnip")
        if not luasnip_ok then
          print("LuaSnip is not installed")
          return
        end

        while true do
          local session = luasnip.session
          local node = session.current_nodes[vim.api.nvim_get_current_buf()]
          if not node then
            print("Removed all snippets")
            return
          end

          luasnip.unlink_current()
        end
      end,
      desc = "Erase autocompletion/snippets stops",
      nowait = true,
      remap = false
    },
    { "<leader>sw", ":mksession! ~/.local/share/nvim/session.vim<cr>",                desc = "Save session",     nowait = true, remap = false },
    { "<leader>sl", ":source ~/.local/share/nvim/session.vim<cr>",                    desc = "Load session",     nowait = true, remap = false },
    { "<leader>sL", ":source ~/.local/share/nvim/sessions/$HOSTNAME/session.vim<cr>", desc = "Load session",     nowait = true, remap = false },
    { "<leader>sk", ":Telescope keymaps<cr>",                                         desc = "Keymaps",          nowait = true, remap = false },
    { "<leader>so", ":Telescope colorscheme<cr>",                                     desc = "Colorscheme",      nowait = true, remap = false },
    { "<leader>sp", ":Telescope live_grep<cr>",                                       desc = "Live Grep",        nowait = true, remap = false },
    { "<leader>sr", ":Telescope oldfiles<cr>",                                        desc = "Open Recent File", nowait = true, remap = false },
    {
      "<leader>st",
      function()
        vim.ui.input({ prompt = "Query: " }, function(q)
          require("telescope.builtin").grep_string({ search = q })
        end)
      end,
      desc = "Grep Text",
      nowait = true,
      remap = false
    },
    { "<leader>u",  ":UndotreeToggle<cr>",        desc = "Toggle Undo Tree",          nowait = true, remap = false },
    { "<leader>w",  group = "Windows",            nowait = true,                      remap = false },
    { "<leader>w-", "<C-w>_",                     desc = "Resize Horizontal Windows", nowait = true, remap = false },
    { "<leader>w=", "<C-w>=",                     desc = "Balance Window",            nowait = true, remap = false },
    { "<leader>wc", "<C-w>c",                     desc = "Close Window",              nowait = true, remap = false },
    { "<leader>wd", "<C-w>c",                     desc = "Close Window",              nowait = true, remap = false },
    { "<leader>wg", ":ChooseWin<cr>",             desc = "Go To Window",              nowait = true, remap = false },
    { "<leader>wh", "<C-w>h",                     desc = "Window Left",               nowait = true, remap = false },
    { "<leader>wj", "<C-w>j",                     desc = "Window Below",              nowait = true, remap = false },
    { "<leader>wk", "<C-w>k",                     desc = "Window Up",                 nowait = true, remap = false },
    { "<leader>wl", "<C-w>l",                     desc = "Window Right",              nowait = true, remap = false },
    { "<leader>wm", "<C-w>o",                     desc = "Maximize window",           nowait = true, remap = false },
    { "<leader>wp", "<C-w>p",                     desc = "Previous Window",           nowait = true, remap = false },
    { "<leader>wr", ":WinResizerStartResize<cr>", desc = "Window Resizer",            nowait = true, remap = false },
    { "<leader>ws", "<C-w>s",                     desc = "Split Window Horizontally", nowait = true, remap = false },
    { "<leader>wv", "<C-w>v",                     desc = "Split Window Vertically",   nowait = true, remap = false },
    { "<leader>ww", "<C-w><C-w>",                 desc = "Switch Window",             nowait = true, remap = false },
    { "<leader>w|", "<C-w>|",                     desc = "Resize Vertical Windows",   nowait = true, remap = false },
  },
}
which_key.setup(options)

if ok_hop then
  local directions = require("hop.hint").HintDirection
  local specs = {
    mode = { "n", "v" },
    { "gs", group = "Hop (Easymotion)", nowait = true, remap = false },
    {
      "gs+",
      function()
        hop.hint_lines_skip_whitespace({
          direction = directions.AFTER_CURSOR,
          current_line_only = false,
        })
      end,
      desc = "Search word forwards",
      nowait = true,
      remap = false
    },
    {
      "gsF",
      function()
        hop.hint_char1({
          direction = directions.BEFORE_CURSOR,
          current_line_only = false,
        })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false
    },
    {
      "gsS",
      function()
        hop.hint_char2({
          direction = directions.BEFORE_CURSOR,
          current_line_only = false,
        })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false
    },
    {
      "gs_",
      function()
        hop.hint_lines_skip_whitespace({
          direction = directions.BEFORE_CURSOR,
          current_line_only = false,
        })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false
    },
    {
      "gsf",
      function()
        hop.hint_char1({
          direction = directions.AFTER_CURSOR,
          current_line_only = false,
        })
      end,
      desc = "Search word forwards",
      nowait = true,
      remap = false
    },
    {
      "gsj",
      function()
        hop.hint_lines({
          direction = directions.AFTER_CURSOR,
          current_line_only = false,
        })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false
    },
    {
      "gsk",
      function()
        hop.hint_lines({
          direction = directions.BEFORE_CURSOR,
          current_line_only = false,
        })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false
    },
    {
      "gss",
      function()
        hop.hint_char2({
          direction = directions.AFTER_CURSOR,
          current_line_only = false,
        })
      end,
      desc = "Search word backwards",
      nowait = true,
      remap = false
    },
  }

  which_key.add(specs)
end
