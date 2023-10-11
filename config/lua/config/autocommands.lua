local groups = {
	general = {
		{
			event = { "BufNewFile", "BufRead" },
			options = {
				callback = function()
					if not vim.g.plugins_loaded then
						require("plugins")
						require("plugins.autopairs")
						require("plugins.cmp")
						require("plugins.comments")
						require("plugins.gitsigns")
						require("plugins.indentline")
						require("plugins.lsp")
						require("plugins.luasnip")
						require("plugins.telescope")
						require("plugins.treesitter")
						vim.g.plugins_loaded = true
					end
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
				pattern = { "nix" },
				command = "set commentstring=#\\ %s",
			},
		},
		{
			event = "FileType",
			options = {
				pattern = { "matlab" },
				command = "set commentstring=\\%\\ %s",
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
	},
	git = {
		{
			event = "FileType",
			options = {
				pattern = { "gitcommit" },
				command = "setlocal wrap",
			},
		},
		{
			event = "FileType",
			options = {
				pattern = { "gitcommit" },
				command = "setlocal spell",
			},
		},
	},
	markdown = {
		{
			event = "FileType",
			options = {
				pattern = { "markdown" },
				command = "setlocal wrap",
			},
		},
		{
			event = "FileType",
			options = {
				pattern = { "markdown" },
				command = "setlocal spell",
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
" Save current view settings on a per-window, per-buffer basis.
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
