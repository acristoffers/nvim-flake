local ok, trim = pcall(require, "trim")
if not ok then
  return
end

trim.setup({
  patterns = {
    [[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
  },
  highlight = false,
})
