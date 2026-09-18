(macro_definition) @function.outer

(probe) @block.outer

(call_expression
  function: (_) @call.inner) @call.outer

[
  (line_comment)
  (block_comment)
] @comment.outer
