require("hop").setup({})

--------------------------------------------------------------------------------
--                                                                            --
--                      Better LSP Code Actions/Quickfix                      --
--                                                                            --
--------------------------------------------------------------------------------

local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a)
      return a.isPreferred
    end,
    apply = true,
  })
end

local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")

local function transform_diagnostics(nvim_diagnostics)
  local lsp_diagnostics = {}
  for _, d in ipairs(nvim_diagnostics) do
    table.insert(lsp_diagnostics, {
      range = {
        start = { line = d.lnum, character = d.col },
        ["end"] = { line = d.end_lnum, character = d.end_col },
      },
      message = d.message,
      severity = d.severity,
      code = d.code,
      source = d.source,
    })
  end
  return lsp_diagnostics
end

local function apply_action_in_document(selected_action)
  local diagnostics = transform_diagnostics(vim.diagnostic.get(0))
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
    context = { diagnostics = diagnostics },
  }

  for _, diagnostic in ipairs(diagnostics) do
    params.range = diagnostic.range
    local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    print(vim.inspect(results))
    for client_id, result in pairs(results) do
      if result.result then
        for _, action in ipairs(result.result) do
          if action.title == selected_action.title then
            if action.edit or type(action.command) == "table" then
              if action.edit then
                local offset_encoding = vim.lsp.get_client_by_id(client_id).offset_encoding
                vim.lsp.util.apply_workspace_edit(action.edit, offset_encoding)
                return apply_action_in_document(selected_action)
              end
              if action.command then
                vim.lsp.buf.execute_command(action.command)
                return apply_action_in_document(selected_action)
              end
            end
          end
        end
      end
    end
  end
end

function GetCodeActionsAndApplyGlobally()
  local diagnostics = transform_diagnostics(vim.diagnostic.get(0))
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
    range = vim.lsp.util.make_range_params().range,
    context = { diagnostics = diagnostics },
  }

  vim.lsp.buf_request_all(0, "textDocument/codeAction", params, function(results)
    local flat_results = {}
    for _, result in pairs(results) do
      if result.result then
        for _, action in ipairs(result.result) do
          table.insert(flat_results, action)
        end
      end
    end

    if #flat_results > 0 then
      pickers
          .new({}, {
            prompt_title = "Code Actions",
            finder = finders.new_table({
              results = flat_results,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.title or "Unnamed action",
                  ordinal = entry.title or "",
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, _)
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                apply_action_in_document(selection.value)
              end)
              return true
            end,
          })
          :find()
    else
      print("No code actions available")
    end
  end)
end

--------------------------------------------------------------------------------
--                                                                            --
--                           Whichkey Configuration                           --
--                                                                            --
--------------------------------------------------------------------------------

local which_key = require("which-key")
local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",       -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                    -- min and max height of the columns
    width = { min = 20, max = 50 },                                    -- min and max width of the columns
    spacing = 3,                                                       -- spacing between columns
    align = "left",                                                    -- align columns left, center or right
  },
  ignore_missing = true,                                               -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                    -- show help message on the command line when the popup is visible
  triggers = "auto",                                                   -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  [";"] = { ":Alpha<cr>", "Dashboard" },
  u = { ":UndotreeToggle<cr>", "Toggle Undo Tree" },
  w = {
    name = "+Windows",
    p = { "<C-w>p", "Previous Window" },
    g = { ":ChooseWin<cr>", "Go To Window" },
    c = { "<C-w>c", "Close Window" },
    d = { "<C-w>c", "Close Window" },
    h = { "<C-w>h", "Window Left" },
    j = { "<C-w>j", "Window Below" },
    l = { "<C-w>l", "Window Right" },
    k = { "<C-w>k", "Window Up" },
    r = { ":WinResizerStartResize<cr>", "Window Resizer" },
    m = { "<C-w>o", "Maximize window" },
    ["="] = { "<C-w>=", "Balance Window" },
    s = { "<C-w>s", "Split Window Horizontally" },
    v = { "<C-w>v", "Split Window Vertically" },
    ["-"] = { "<C-w>_", "Resize Horizontal Windows" },
    ["|"] = { "<C-w>|", "Resize Vertical Windows" },
    w = { "<C-w><C-w>", "Switch Window" },
  },
  q = {
    name = "+Quit",
    q = { ":qa<cr>", "Quit Neovim" },
    w = { ":xa<cr>", "Quit Saving Everything" },
    Q = { ":qa!<cr>", "Quit Anyway (without saving)" },
  },
  c = {
    name = "+Code",
    A = { GetCodeActionsAndApplyGlobally, "Code Action (Apply in buffer)" },
    a = { ":lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      ":Telescope diagnostics bufnr=0 theme=get_ivy<cr>",
      "Buffer Diagnostics",
    },
    w = { ":Telescope diagnostics<cr>", "Diagnostics" },
    f = { ":Format<cr>", "Format" },
    h = { ":Ouroboros<cr>", "Switch .h/.cpp" },
    i = { ":LspInfo<cr>", "Info" },
    I = { ":LspInstallInfo<cr>", "Installer Info" },
    j = {
      vim.diagnostic.goto_next,
      "Next Diagnostic",
    },
    k = {
      vim.diagnostic.goto_prev,
      "Prev Diagnostic",
    },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { quickfix, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
    s = { ":Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      ":Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    e = { ":Telescope quickfix<cr>", "Telescope Quickfix" },
  },
  f = {
    name = "+File",
    n = { ":ene!<cr>", "New file" },
    s = { ":silent w<cr>", "Save File" },
    a = { ":silent wa<cr>", "Save All" },
    o = {
      ":lua require'telescope.builtin'.find_files()<cr>",
      "Find File",
    },
    g = {
      ":lua require'telescope.builtin'.git_files()<cr>",
      "Find Git File",
    },
    p = { ":e ~/.config/nvim/init.lua <cr>", "Open Config File" },
    h = { ":wshada!<cr>", "Save shada (fixes overpersistent marks)" },
    w = { ":%s/ \\+$//g<cr>", "Remove trailling spaces" },
  },
  [" "] = {
    ":lua require'telescope.builtin'.find_files()<cr>",
    "Find File",
  },
  b = {
    name = "+Buffers",
    b = { ":BufferLinePick<cr>", "Go to Buffer (BufferLine)" },
    B = { ":Telescope buffers<cr>", "Go to Buffer (Telescope)" },
    p = { ":BufferLineCyclePrev<cr>", "Previous" },
    n = { ":BufferLineCycleNext<cr>", "Next" },
    k = { ":bd<cr>", "Close Buffer" },
    K = { ":bd!<cr>", "Force Close Buffer" },
    e = {
      ":BufferLinePickClose<cr>",
      "Pick which buffer to close",
    },
    h = { ":BufferLineCloseLeft<cr>", "Close all to the left" },
    l = {
      ":BufferLineCloseRight<cr>",
      "Close all to the right",
    },
    D = {
      ":BufferLineSortByDirectory<cr>",
      "Sort by directory",
    },
    L = {
      ":BufferLineSortByExtension<cr>",
      "Sort by language",
    },
    o = {
      ":BufferLineCloseRight<cr><cmd>BufferLineCloseLeft<cr>",
      "Close Others",
    },
    r = {
      ":e!<cr>",
      "Reload current buffer",
    },
  },
  e = {
    ":NvimTreeToggle<CR>",
    "Toggle File Tree",
  },
  -- " Available Debug Adapters:
  -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
  -- " Adapter configuration and installation instructions:
  -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  -- " Debug Adapter protocol:
  -- "   https://microsoft.github.io/debug-adapter-protocol/
  -- " Debugging
  g = {
    name = "+Git",
    j = { ":lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { ":lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      ":lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { ":Telescope git_status<cr>", "Open changed file" },
    b = { ":Telescope git_branches<cr>", "Checkout branch" },
    c = { ":Telescope git_commits<cr>", "Checkout commit" },
    C = {
      ":Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    d = {
      ":Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
  },
  l = {
    name = "+LSP",
    a = { ":lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      ":Telescope diagnostics bufnr=0 theme=get_ivy<cr>",
      "Buffer Diagnostics",
    },
    w = { ":Telescope diagnostics<cr>", "Diagnostics" },
    f = { ":lua vim.lsp.buf.format()<cr>", "Format" },
    i = { ":LspInfo<cr>", "Info" },
    I = { ":LspInstallInfo<cr>", "Installer Info" },
    j = {
      vim.diagnostic.goto_next,
      "Next Diagnostic",
    },
    k = {
      vim.diagnostic.goto_prev,
      "Prev Diagnostic",
    },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
    s = { ":Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      ":Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    e = { ":Telescope quickfix<cr>", "Telescope Quickfix" },
    o = { vim.diagnostic.open_float, "Open Float" },
  },
  p = {
    name = "+Projects",
    p = {
      function()
        require("telescope").extensions.projects.projects({})
      end,
      "Open Project",
    },
  },
  s = {
    name = "+Search",
    b = { ":Telescope git_branches<cr>", "Checkout branch" },
    o = { ":Telescope colorscheme<cr>", "Colorscheme" },
    f = { ":Telescope find_files<cr>", "Find File" },
    h = { ":Telescope help_tags<cr>", "Find Help" },
    H = { ":Telescope highlights<cr>", "Find highlight groups" },
    M = { ":Telescope man_pages<cr>", "Man Pages" },
    r = { ":Telescope oldfiles<cr>", "Open Recent File" },
    R = { ":Telescope registers<cr>", "Registers" },
    p = { ":Telescope live_grep<cr>", "Live Grep" },
    i = {
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
      "Erase autocompletion/snippets stops",
    },
    P = {
      ':lua require"telescope.builtin".live_grep {cwd="~/.config/nvim"}<cr>',
      "Live Grep Config",
    },
    t = {
      function()
        vim.ui.input("Query: ", function(q)
          require("telescope.builtin").grep_string({ search = q })
        end)
      end,
      "Grep Text",
    },
    k = { ":Telescope keymaps<cr>", "Keymaps" },
    C = { ":Telescope commands<cr>", "Commands" },
    T = {
      ":lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
    c = { ":nohlsearch<cr>", "No Highlight" },
  },
  T = {
    name = "+Treesitter",
    i = { ":Inspect<cr>", "Inspect" },
    t = { ":InspectTree<cr>", "Inspect Tree" },
  },
  h = {
    name = "Help",
    k = { ":Telescope keymaps<cr>", "Keymaps" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)

local hop_ok, hop = pcall(require, "hop")
if hop_ok then
  local directions = require("hop.hint").HintDirection
  local gopts_n = {
    mode = "n",     -- Normal mode
    prefix = "g",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }
  local gopts_v = {
    mode = "v",     -- Visual mode
    prefix = "g",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }
  local gmappings = {
    ["s"] = {
      name = "Hop (Easymotion)",
      f = {
        function()
          hop.hint_char1({
            direction = directions.AFTER_CURSOR,
            current_line_only = false,
          })
        end,
        "Search word forwards",
      },
      F = {
        function()
          hop.hint_char1({
            direction = directions.BEFORE_CURSOR,
            current_line_only = false,
          })
        end,
        "Search word backwards",
      },
      s = {
        function()
          hop.hint_char2({
            direction = directions.AFTER_CURSOR,
            current_line_only = false,
          })
        end,
        "Search word backwards",
      },
      S = {
        function()
          hop.hint_char2({
            direction = directions.BEFORE_CURSOR,
            current_line_only = false,
          })
        end,
        "Search word backwards",
      },
      k = {
        function()
          hop.hint_lines({
            direction = directions.BEFORE_CURSOR,
            current_line_only = false,
          })
        end,
        "Search word backwards",
      },
      j = {
        function()
          hop.hint_lines({
            direction = directions.AFTER_CURSOR,
            current_line_only = false,
          })
        end,
        "Search word backwards",
      },
      _ = {
        function()
          hop.hint_lines_skip_whitespace({
            direction = directions.BEFORE_CURSOR,
            current_line_only = false,
          })
        end,
        "Search word backwards",
      },
      ["+"] = {
        function()
          hop.hint_lines_skip_whitespace({
            direction = directions.AFTER_CURSOR,
            current_line_only = false,
          })
        end,
        "Search word backwards",
      },
    },
  }
  which_key.register(gmappings, gopts_n)
  which_key.register(gmappings, gopts_v)
end
