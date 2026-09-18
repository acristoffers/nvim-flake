(function_declaration
  body: (_) @function.inner) @function.outer

(parameter) @parameter.outer

(if_statement
  consequence: (_) @conditional.inner) @conditional.outer

(else_statement
  alternative: (_) @conditional.inner)

(switch_expression) @conditional.outer
(match_expression) @conditional.outer
(case
  (_) @conditional.inner)

(for_statement
  body: (_) @loop.inner) @loop.outer

(call_expression
  callee: (_) @call.inner) @call.outer

(block) @block.outer
(block
  (statement) @block.inner)

(comment) @comment.outer
