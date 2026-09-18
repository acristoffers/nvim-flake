(function_expression) @call.outer
(method_expression) @call.outer

(argument
  (_) @parameter.inner @parameter.outer)

(key_value_item) @parameter.outer @parameter.inner

(selection_statement) @conditional.outer
(iteration_statement) @loop.outer

(comment) @comment.outer
