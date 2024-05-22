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
        pattern = "*.proto",
        callback = function()
          vim.cmd([[set filetype=wbproto]])
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
  },
  general = {
    {
      event = { "BufNewFile", "BufRead" },
      options = {
        pattern = { "*.m" },
        command = "set filetype=matlab",
      },
    },
    -- {
    --   event = "FileType",
    --   options = {
    --     pattern = { "nix" },
    --     command = "set commentstring=#\\ %s",
    --   },
    -- },
    -- {
    --   event = "FileType",
    --   options = {
    --     pattern = { "matlab" },
    --     command = "set commentstring=\\%\\ %s",
    --   },
    -- },
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
