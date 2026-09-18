(call_expression
  (block) @call.inner) @call.outer

(call_expression) @call.outer

(if_statement
  consequence: (block) @conditional.inner) @conditional.outer

(else_statement
  alternative: (_) @conditional.inner)

(foreach_statement
  (block) @loop.inner) @loop.outer

(block) @block.outer
(block
  (statement) @block.inner)

(comment) @comment.outer
