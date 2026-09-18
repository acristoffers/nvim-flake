[
  (function_declaration)
  (function_definition)
] @function.outer

(do_statement) @block.outer

(table_constructor) @block.outer

[
  (if_statement)
  (if_expression)
] @conditional.outer

[
  (while_statement)
  (repeat_statement)
  (for_statement)
] @loop.outer

(parameter) @parameter.outer @parameter.inner

[
  (function_call)
  (method_index_expression)
] @call.outer

(function_call
  arguments: (arguments) @call.inner)

(comment) @comment.outer
