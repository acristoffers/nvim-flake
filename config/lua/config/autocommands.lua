local groups = {
  initialization = {
    {
      event = "BufEnter",
      options = {
        callback = function()
          vim.cmd([[silent LspStart]])
        end,
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
  },
  by_filetype = {
    {
      event = "FileType",
      options = {
        pattern = { "flutter", "dart" },
        callback = function()
          vim.defer_fn(function()
            require("flutter-tools").setup({})
          end, 500)
        end,
      },
    },
    {
      event = "FileType",
      options = {
        pattern = { "rust" },
        callback = function()
          vim.defer_fn(function()
            require("rust-tools").setup({})
          end, 500)
        end,
      },
    },
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
          local opts = { buffer = true, silent = true, noremap = true }
          vim.keymap.set("x", "ie", ':lua NamedNodeSnipe({"xact"})<cr>', opts)
          vim.keymap.set("o", "ie", ':lua NamedNodeSnipe({"xact"})<cr>', opts)
          vim.keymap.set("x", "il", ':lua NamedNodeSnipe({"payee"})<cr>', opts)
          vim.keymap.set("o", "il", ':lua NamedNodeSnipe({"payee"})<cr>', opts)
          vim.keymap.set("x", "iv", ':lua NamedNodeSnipe({"quantity"})<cr>', opts)
          vim.keymap.set("o", "iv", ':lua NamedNodeSnipe({"quantity"})<cr>', opts)
          vim.keymap.set("n", "<Space>me", ':normal civ<cr>', opts)
          vim.keymap.set("n", "<Space>ml", ':normal {cil<cr>', opts)
        end,
      },
    },
    {
      event = "FileType",
      options = {
        pattern = { "tex" },
        callback = function()
          local opts = { buffer = true, silent = true, noremap = true }
          local select = require 'nvim-treesitter.textobjects.select'.select_textobject
          vim.keymap.set("x", "am", function() select("@math.outer") end, opts)
          vim.keymap.set("o", "am", function() select("@math.outer") end, opts)
          vim.keymap.set("x", "im", function() select("@math.inner") end, opts)
          vim.keymap.set("o", "im", function() select("@math.inner") end, opts)

          vim.keymap.set("x", "aS", function() select("@class.outer") end, opts)
          vim.keymap.set("o", "aS", function() select("@class.outer") end, opts)
          vim.keymap.set("x", "iS", function() select("@class.inner") end, opts)
          vim.keymap.set("o", "iS", function() select("@class.inner") end, opts)

          vim.keymap.set("x", "ae", function() select("@block.outer") end, opts)
          vim.keymap.set("o", "ae", function() select("@block.outer") end, opts)
          vim.keymap.set("x", "ie", function() select("@block.inner") end, opts)
          vim.keymap.set("o", "ie", function() select("@block.inner") end, opts)

          vim.keymap.set("x", "ac", function() select("@command.outer") end, opts)
          vim.keymap.set("o", "ac", function() select("@command.outer") end, opts)
          vim.keymap.set("x", "ic", function() select("@command.inner") end, opts)
          vim.keymap.set("o", "ic", function() select("@command.inner") end, opts)

          vim.keymap.set("x", "aa", function() select("@parameter.outer") end, opts)
          vim.keymap.set("o", "aa", function() select("@parameter.outer") end, opts)
          vim.keymap.set("x", "ia", function() select("@parameter.inner") end, opts)
          vim.keymap.set("o", "ia", function() select("@parameter.inner") end, opts)

          vim.keymap.set("x", "af", function() select("@call.outer") end, opts)
          vim.keymap.set("o", "af", function() select("@call.outer") end, opts)
          vim.keymap.set("x", "if", function() select("@call.inner") end, opts)
          vim.keymap.set("o", "if", function() select("@call.inner") end, opts)

          vim.keymap.set("x", "a^", function() select("@superscript.outer") end, opts)
          vim.keymap.set("o", "a^", function() select("@superscript.outer") end, opts)
          vim.keymap.set("x", "i^", function() select("@superscript.inner") end, opts)
          vim.keymap.set("o", "i^", function() select("@superscript.inner") end, opts)

          vim.keymap.set("x", "a_", function() select("@subscript.outer") end, opts)
          vim.keymap.set("o", "a_", function() select("@subscript.outer") end, opts)
          vim.keymap.set("x", "i_", function() select("@subscript.inner") end, opts)
          vim.keymap.set("o", "i_", function() select("@subscript.inner") end, opts)

          vim.keymap.set("x", "an", function() select("@item.outer") end, opts)
          vim.keymap.set("o", "an", function() select("@item.outer") end, opts)
          vim.keymap.set("x", "in", function() select("@item.inner") end, opts)
          vim.keymap.set("o", "in", function() select("@item.inner") end, opts)
        end,
      },
    },
  },
  general = {
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
          local hl_ok, hl = pcall(require, "vim.highlight")
          if hl_ok then
            hl.on_yank({ higroup = "Search", timeout = 200 })
          else
            print("Require error: no vim.highlight")
          end
        end,
      },
    },
    {
      event = "BufWinEnter",
      options = { command = "set formatoptions-=cro" },
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
