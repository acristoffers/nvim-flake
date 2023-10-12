function Load()
	require("plugins.other")
	require("plugins.autopairs")
	require("plugins.cmp")
	require("plugins.comments")
	require("plugins.gitsigns")
	require("plugins.lsp")
	require("plugins.luasnip")
	require("plugins.treesitter")
end

local groups = {
	initialization = {
		{
			event = "UIEnter",
			options = {
				callback = function()
					require("plugins.telescope")
					require("plugins.whichkey")
				end,
			},
		},
		{
			event = { "BufRead" },
			options = {
				callback = Load,
			},
		},
	},
	by_filetype = {
		{
			event = "FileType",
			options = {
				pattern = { "flutter", "dart" },
				callback = function()
					vim.cmd("packadd flutter-tools.nvim")
					require("flutter-tools").setup({})
				end,
			},
		},
		{
			event = "FileType",
			options = {
				pattern = { "julia" },
				callback = function()
					vim.cmd("packadd julia-vim")
				end,
			},
		},
		{
			event = "FileType",
			options = {
				pattern = { "rust" },
				callback = function()
					vim.cmd("packadd rust-tools.nvim")
					require("rust-tools").setup({})
				end,
			},
		},
		{
			event = "FileType",
			options = {
				pattern = { "fish" },
				callback = function()
					vim.cmd([[
                        packadd vim-fish
                        compiler fish
                        setlocal textwidth=79
                        setlocal foldmethod=expr
                    ]])
				end,
			},
		},
		{
			event = "FileType",
			options = {
				pattern = { "tex", "latex", "bib" },
				callback = function()
					vim.cmd("packadd vimtex")
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
