local ok, markview = pcall(require, "markview")
if not ok then
  return
end

markview.setup({
  preview = {
    edit_range = { 0, 0 },
    filetypes = { "markdown", "codecompanion" },
    hybrid_modes = { "n", "i" },
    icon_provider = "mini",
    ignore_buftypes = {},
    linewise_hybrid_mode = true,
    modes = { "n", "i" },
  },
})
