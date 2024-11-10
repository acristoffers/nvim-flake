local ok, _ = pcall(require, "rainbow-delimiters")
if not ok then
    return
end

require("rainbow-delimiters.setup").setup({
    strategy = {
        [""] = require("rainbow-delimiters").strategy["global"],
    },
    query = {
        [""] = "rainbow-delimiters",
    },
    priority = {
        [""] = 110,
        lua = 210,
    },
})
