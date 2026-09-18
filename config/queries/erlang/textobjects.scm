(fun_decl) @function.outer
(function_clause
  (clause_body) @function.inner)

(case_expr) @conditional.outer
(if_expr) @conditional.outer
(try_expr) @conditional.outer
(receive_expr) @conditional.outer

(cr_clause
  (clause_body) @conditional.inner)
(if_clause
  (clause_body) @conditional.inner)

(call) @call.outer
(expr_args
  (_) @parameter.inner @parameter.outer)

(comment) @comment.outer
