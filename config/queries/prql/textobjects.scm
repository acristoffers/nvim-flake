(function_definition) @function.outer

(function_call) @call.outer

(function_call
  (identifier) @call.inner)

(parameter) @parameter.outer @parameter.inner

(comment) @comment.outer
