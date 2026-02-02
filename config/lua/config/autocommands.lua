local groups = {
  initialization = {
    {
      event = "BufWinEnter",
      options = {
        callback = function()
          vim.schedule(function()
            vim.cmd("redraw!")
          end)
        end
      },
    },
    {
      event = { "BufRead", "BufNewFile" },
      options = {
        pattern = "*.zon",
        callback = function()
          vim.cmd([[set filetype=zig]])
        end,
      },
    },
    {
      event = { "BufRead", "BufNewFile" },
      options = {
        pattern = { "*.proto", "*.wbt" },
        callback = function()
          vim.cmd([[
            set filetype=wbproto
            set cms=#%s
          ]])
        end,
      },
    },
    {
      event = { "BufRead", "BufNewFile" },
      options = {
        pattern = "*.mixin",
        callback = function()
          vim.cmd([[set filetype=yaml]])
        end,
      },
    },
  },
  by_filetype = {
    {
      event = "FileType",
      options = {
        pattern = { "fish" },
        callback = function()
          vim.cmd([[
            compiler fish
            setlocal foldmethod=expr
          ]])
        end,
      },
    },
    {
      event = "FileType",
      options = {
        pattern = { "ledger" },
        callback = function()
          local opts = { buffer = true, silent = true }
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
          end

          map("x", "iv", ':lua NamedNodeSnipe({"xact"})<cr>', "Select transaction")
          map("o", "iv", ':lua NamedNodeSnipe({"xact"})<cr>', "Select transaction")
          map("x", "il", ':lua NamedNodeSnipe({"payee"})<cr>', "Select payee")
          map("o", "il", ':lua NamedNodeSnipe({"payee"})<cr>', "Select payee")
          map("x", "ie", ':lua NamedNodeSnipe({"quantity"})<cr>', "Select amount")
          map("o", "ie", ':lua NamedNodeSnipe({"quantity"})<cr>', "Select amount")
          map("n", "<leader>ma", ":LedgerAddEntry<cr>", "Add ledger entry")
          map("n", "<leader>mf", ":LedgerFormat<cr>", "Format")
          map("n", "<leader>mo", ":LedgerReport<cr>", "Show daily ledger report")
          map("n", "<leader>mv", ":LedgerSelectDate<cr>", "Select transactions by date")
          map("n", "<leader>me", ":LedgerSelectAmount<cr>c", "Edit amount")
          map("n", "<leader>ml", ":LedgerSelectPayee<cr>c", "Edit payee")
          SetTab(4)
          vim.bo.commentstring = "; %s"
        end,
      },
    },
    {
      event = "FileType",
      options = {
        pattern = { "tex" },
        callback = function()
          local ok, ts_select = pcall(require, "nvim-treesitter.textobjects.select")
          if not ok then
            return
          end
          local opts = { buffer = true, silent = true, noremap = true }
          local select = ts_select.select_textobject
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
          end

          map("x", "am", function() select("@math.outer") end, "Select math (outer)")
          map("o", "am", function() select("@math.outer") end, "Select math (outer)")
          map("x", "im", function() select("@math.inner") end, "Select math (inner)")
          map("o", "im", function() select("@math.inner") end, "Select math (inner)")

          map("x", "aS", function() select("@class.outer") end, "Select class (outer)")
          map("o", "aS", function() select("@class.outer") end, "Select class (outer)")
          map("x", "iS", function() select("@class.inner") end, "Select class (inner)")
          map("o", "iS", function() select("@class.inner") end, "Select class (inner)")

          map("x", "ae", function() select("@block.outer") end, "Select block (outer)")
          map("o", "ae", function() select("@block.outer") end, "Select block (outer)")
          map("x", "ie", function() select("@block.inner") end, "Select block (inner)")
          map("o", "ie", function() select("@block.inner") end, "Select block (inner)")

          map("x", "ac", function() select("@command.outer") end, "Select command (outer)")
          map("o", "ac", function() select("@command.outer") end, "Select command (outer)")
          map("x", "ic", function() select("@command.inner") end, "Select command (inner)")
          map("o", "ic", function() select("@command.inner") end, "Select command (inner)")

          map("x", "aa", function() select("@parameter.outer") end, "Select parameter (outer)")
          map("o", "aa", function() select("@parameter.outer") end, "Select parameter (outer)")
          map("x", "ia", function() select("@parameter.inner") end, "Select parameter (inner)")
          map("o", "ia", function() select("@parameter.inner") end, "Select parameter (inner)")

          map("x", "af", function() select("@call.outer") end, "Select call (outer)")
          map("o", "af", function() select("@call.outer") end, "Select call (outer)")
          map("x", "if", function() select("@call.inner") end, "Select call (inner)")
          map("o", "if", function() select("@call.inner") end, "Select call (inner)")

          map("x", "a^", function() select("@superscript.outer") end, "Select superscript (outer)")
          map("o", "a^", function() select("@superscript.outer") end, "Select superscript (outer)")
          map("x", "i^", function() select("@superscript.inner") end, "Select superscript (inner)")
          map("o", "i^", function() select("@superscript.inner") end, "Select superscript (inner)")

          map("x", "a_", function() select("@subscript.outer") end, "Select subscript (outer)")
          map("o", "a_", function() select("@subscript.outer") end, "Select subscript (outer)")
          map("x", "i_", function() select("@subscript.inner") end, "Select subscript (inner)")
          map("o", "i_", function() select("@subscript.inner") end, "Select subscript (inner)")

          map("x", "an", function() select("@item.outer") end, "Select item (outer)")
          map("o", "an", function() select("@item.outer") end, "Select item (outer)")
          map("x", "in", function() select("@item.inner") end, "Select item (inner)")
          map("o", "in", function() select("@item.inner") end, "Select item (inner)")
        end,
      },
    },
  },
  general = {
    {
      event = { "BufWrite" },
      options = {
        callback = function()
          vim.cmd([[
            call mkdir($HOME .. "/.local/share/nvim/sessions/" .. $HOSTNAME, "p")
            mksession! $HOME/.local/share/nvim/sessions/$HOSTNAME/session.vim
          ]])
        end,
      },
    },
    {
      event = { "BufNewFile", "BufRead" },
      options = {
        pattern = { "*.m" },
        command = "set filetype=matlab",
      },
    },
    {
      event = "FileType",
      options = {
        pattern = { "qf", "help", "man", "lspinfo" },
        command = "nnoremap <silent> <buffer> q :close<cr>",
      },
    },
    {
      event = "TextYankPost",
      options = {
        callback = function()
          local hl_ok, hl = pcall(require, "vim.hl")
          if hl_ok then
            hl.on_yank({ higroup = "Search", timeout = 200 })
          else
            print("Require error: no vim.hl")
          end
        end,
      },
    },
    {
      event = "BufWinEnter",
      options = { command = "set formatoptions+=cro" },
    },
    {
      event = "FileType",
      options = {
        pattern = { "qf" },
        command = "set nobuflisted",
      },
    },
    {
      event = "FileType",
      options = {
        pattern = { "gitcommit", "markdown" },
        callback = function()
          vim.cmd([[
            setlocal wrap
            setlocal spell
          ]])
          SetTab(2)
          local ok, ts_select = pcall(require, "nvim-treesitter.textobjects.select")
          if not ok then
            return
          end
          local opts = { buffer = true, silent = true, noremap = true }
          local select = ts_select.select_textobject
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
          end

          map("x", "aS", function() select("@section.outer") end, "Select section (outer)")
          map("o", "aS", function() select("@section.outer") end, "Select section (outer)")
          map("x", "iS", function() select("@section.inner") end, "Select section (inner)")
          map("o", "iS", function() select("@section.inner") end, "Select section (inner)")

          map("x", "ai", function() select("@list_item.outer") end, "Select list item (outer)")
          map("o", "ai", function() select("@list_item.outer") end, "Select list item (outer)")
          map("x", "ii", function() select("@list_item.inner") end, "Select list item (inner)")
          map("o", "ii", function() select("@list_item.inner") end, "Select list item (inner)")

          map("x", "al", function() select("@list.outer") end, "Select list (outer)")
          map("o", "al", function() select("@list.outer") end, "Select list (outer)")
          map("x", "il", function() select("@list.inner") end, "Select list (inner)")
          map("o", "il", function() select("@list.inner") end, "Select list (inner)")

          map("x", "am", ':lua NamedNodeSnipe({"latex_block"})<cr>', "Select LaTeX block")
          map("o", "am", ':lua NamedNodeSnipe({"latex_block"})<cr>', "Select LaTeX block")
        end,
      },
    },
  },
  autoresize = {
    {
      event = "VimResized",
      options = { command = "tabdo wincmd =" },
    },
  },
}

for group, events in pairs(groups) do
  local augroup = vim.api.nvim_create_augroup(group, { clear = true })
  for _, event in pairs(events) do
    local options = vim.tbl_extend("keep", { group = augroup }, event.options)
    vim.api.nvim_create_autocmd(event.event, options)
  end
end

vim.cmd([[
"Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif
]])
