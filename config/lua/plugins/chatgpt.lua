if vim.fn.getenv("OPENAI_API_KEY") == nil then
  return
end

local ok, chatgpt = pcall(require, "chatgpt")
if not ok then
  return
end

chatgpt.setup({
  openai_params = {
    model = "gpt-4",
  },
})
