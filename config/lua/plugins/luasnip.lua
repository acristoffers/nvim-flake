require("luasnip.loaders.from_vscode").lazy_load()

local luasnip = require("luasnip")

luasnip.setup({
	history = true,
	delete_check_events = "TextChanged",
})

luasnip.add_snippets("all", {
	luasnip.snippet("#!", {
		-- Simple static text.
		luasnip.text_node("#!/usr/bin/env "),
		-- function, first parameter is the function, second the Placeholders
		-- whose text it gets as input.
		luasnip.insert_node(1),
	}),
})
