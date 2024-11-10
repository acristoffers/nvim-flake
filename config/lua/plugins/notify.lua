local ok, notify = pcall(require, "notify")
if not ok then
  return
end

notify.setup({
  timeout = 3000,
  background_colour = "#282a36",
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
})
vim.notify = require("notify")
