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
  highlight = {
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
    "RainbowDelimiterRed",
  },
})
