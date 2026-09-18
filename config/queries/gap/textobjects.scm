(function
  body: (_) @function.inner) @function.outer

(atomic_function
  body: (_) @function.inner) @function.outer

(lambda) @function.outer
(lambda
  body: (_) @function.inner)

(parameters
  (identifier) @parameter.inner @parameter.outer)

(qualified_parameters
  (identifier) @parameter.inner @parameter.outer)

(lambda_parameters
  (identifier) @parameter.inner @parameter.outer)

(if_statement) @conditional.outer
(if_statement
  body: (_) @conditional.inner)

(elif_clause
  body: (_) @conditional.inner)

(else_clause
  body: (_) @conditional.inner)

(while_statement
  body: (_) @loop.inner) @loop.outer

(repeat_statement
  body: (_) @loop.inner) @loop.outer

(for_statement
  body: (_) @loop.inner) @loop.outer

(call) @call.outer
(call
  arguments: (_) @call.inner)

(comment) @comment.outer
