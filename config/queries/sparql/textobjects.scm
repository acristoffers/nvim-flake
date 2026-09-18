(function_call
  identifier: (_) @call.inner) @call.outer

(select_clause
  bound_variable: (var) @parameter.inner @parameter.outer)

(bind
  bound_variable: (var) @parameter.inner @parameter.outer)

(comment) @comment.outer
