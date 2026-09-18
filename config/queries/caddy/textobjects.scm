; Directive / site blocks
(block
  "{"
  .
  _+ @block.inner
  .
  "}") @block.outer

(directive) @statement.outer

(comment) @comment.outer
