vim.loader.enable()

if not vim.go.loadplugins then
	vim.cmd([[se nu rnu]])
else
	require("plugins.alpha")
	require("plugins.bufferline")
	require("plugins.lualine")

	require("config.autocommands")
	require("config.keybindings")
	require("config.options")
end
