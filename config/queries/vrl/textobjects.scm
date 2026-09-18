(if_statement
  (block) @conditional.inner) @conditional.outer

(function_call) @call.outer

(arguments) @call.inner

(named_argument
  value: (_) @parameter.inner) @parameter.outer

(closure
  (closure_variables) @function.inner
  body: (block) @function.inner) @function.outer

(closure_variables
  (ident) @parameter.inner @parameter.outer)

(assignment) @statement.outer

(comment) @comment.outer
