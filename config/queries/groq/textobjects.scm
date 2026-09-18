(function_call) @call.outer

(projection) @block.outer
(projection
  (_) @block.inner)

(conditional_projection) @conditional.outer
(select_statement) @conditional.outer

(pipe_expression) @statement.outer
