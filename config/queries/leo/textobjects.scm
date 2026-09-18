[
  (function_declaration)
  (transition_declaration)
  (finalizer)
  (inline_declaration)
] @function.outer

[
  (struct_declaration)
  (record_declaration)
] @class.outer

(function_parameter) @parameter.outer @parameter.inner

[
  (free_function_call)
  (associated_function_call)
  (method_call)
] @call.outer

(comment) @comment.outer
