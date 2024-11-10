local ok, comment = pcall(require, "Comment")
if not ok then
  return
end

local ok_tscc, tscc = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if not ok_tscc then
  return
end

comment.setup({
  pre_hook = tscc.create_pre_hook(),
})
