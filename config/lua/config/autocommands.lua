local groups = {
  initialization = {
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
          vim.keymap.set("x", "ie", ':lua NamedNodeSnipe({"xact"})<cr>', opts)
          vim.keymap.set("o", "ie", ':lua NamedNodeSnipe({"xact"})<cr>', opts)
          vim.keymap.set("x", "il", ':lua NamedNodeSnipe({"payee"})<cr>', opts)
          vim.keymap.set("o", "il", ':lua NamedNodeSnipe({"payee"})<cr>', opts)
          vim.keymap.set("x", "iv", ':lua NamedNodeSnipe({"quantity"})<cr>', opts)
          vim.keymap.set("o", "iv", ':lua NamedNodeSnipe({"quantity"})<cr>', opts)
          -- Because of some weird behavior in vim.keymap.set, bindings with
          -- text-objects don't work and I have to use nmap instead
          vim.cmd([[nmap <Leader>me civ]])
          vim.cmd([[nmap <Leader>ml {cil]])
          vim.keymap.set("n", "<leader>ma", ":lua InsertLedgerEntry()<cr>", opts)
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
          vim.keymap.set("x", "am", function()
            select("@math.outer")
          end, opts)
          vim.keymap.set("o", "am", function()
            select("@math.outer")
          end, opts)
          vim.keymap.set("x", "im", function()
            select("@math.inner")
          end, opts)
          vim.keymap.set("o", "im", function()
            select("@math.inner")
          end, opts)

          vim.keymap.set("x", "aS", function()
            select("@class.outer")
          end, opts)
          vim.keymap.set("o", "aS", function()
            select("@class.outer")
          end, opts)
          vim.keymap.set("x", "iS", function()
            select("@class.inner")
          end, opts)
          vim.keymap.set("o", "iS", function()
            select("@class.inner")
          end, opts)

          vim.keymap.set("x", "ae", function()
            select("@block.outer")
          end, opts)
          vim.keymap.set("o", "ae", function()
            select("@block.outer")
          end, opts)
          vim.keymap.set("x", "ie", function()
            select("@block.inner")
          end, opts)
          vim.keymap.set("o", "ie", function()
            select("@block.inner")
          end, opts)

          vim.keymap.set("x", "ac", function()
            select("@command.outer")
          end, opts)
          vim.keymap.set("o", "ac", function()
            select("@command.outer")
          end, opts)
          vim.keymap.set("x", "ic", function()
            select("@command.inner")
          end, opts)
          vim.keymap.set("o", "ic", function()
            select("@command.inner")
          end, opts)

          vim.keymap.set("x", "aa", function()
            select("@parameter.outer")
          end, opts)
          vim.keymap.set("o", "aa", function()
            select("@parameter.outer")
          end, opts)
          vim.keymap.set("x", "ia", function()
            select("@parameter.inner")
          end, opts)
          vim.keymap.set("o", "ia", function()
            select("@parameter.inner")
          end, opts)

          vim.keymap.set("x", "af", function()
            select("@call.outer")
          end, opts)
          vim.keymap.set("o", "af", function()
            select("@call.outer")
          end, opts)
          vim.keymap.set("x", "if", function()
            select("@call.inner")
          end, opts)
          vim.keymap.set("o", "if", function()
            select("@call.inner")
          end, opts)

          vim.keymap.set("x", "a^", function()
            select("@superscript.outer")
          end, opts)
          vim.keymap.set("o", "a^", function()
            select("@superscript.outer")
          end, opts)
          vim.keymap.set("x", "i^", function()
            select("@superscript.inner")
          end, opts)
          vim.keymap.set("o", "i^", function()
            select("@superscript.inner")
          end, opts)

          vim.keymap.set("x", "a_", function()
            select("@subscript.outer")
          end, opts)
          vim.keymap.set("o", "a_", function()
            select("@subscript.outer")
          end, opts)
          vim.keymap.set("x", "i_", function()
            select("@subscript.inner")
          end, opts)
          vim.keymap.set("o", "i_", function()
            select("@subscript.inner")
          end, opts)

          vim.keymap.set("x", "an", function()
            select("@item.outer")
          end, opts)
          vim.keymap.set("o", "an", function()
            select("@item.outer")
          end, opts)
          vim.keymap.set("x", "in", function()
            select("@item.inner")
          end, opts)
          vim.keymap.set("o", "in", function()
            select("@item.inner")
          end, opts)
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
          SetTab(2)
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
