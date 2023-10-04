require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").setup({
	history = true,
	delete_check_events = "TextChanged",
})

local snippets = require("luasnip")
snippets.add_snippets("all", {
	snippets.snippet("#!", {
		-- Simple static text.
		snippets.text_node("#!/usr/bin/env "),
		-- function, first parameter is the function, second the Placeholders
		-- whose text it gets as input.
		snippets.insert_node(1),
	}),
})
