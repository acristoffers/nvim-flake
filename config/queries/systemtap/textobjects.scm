(function_definition) @function.outer

(function_definition
  (statement_block) @function.inner)

(if_statement) @conditional.outer

(try_statement) @conditional.outer

(while_statement) @loop.outer
(for_statement) @loop.outer
(foreach_statement) @loop.outer

(_
  (statement_block) @block.inner) @block.outer

(comment) @comment.outer

(call_expression) @call.outer

(parameter
  name: (identifier) @parameter.inner @parameter.outer)
