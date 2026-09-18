(section
  (heading)
  .
  (_)+ @section.inner
  .) @section.outer

(list) @list.outer @list.inner

(list_item (_) (_) @list_item.inner) @list_item.outer

[
  (code_block)
  (raw_block)
  (div)
] @block.outer

[
  (comment)
  (inline_comment)
] @comment.outer
