(fun_expr) @function.outer

(fun_expr
  pats: (pattern_fun
    (ident) @parameter.inner @parameter.outer))

(applicative) @call.outer

(comment) @comment.outer
