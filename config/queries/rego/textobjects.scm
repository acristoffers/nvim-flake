(rule
  (rule_body) @function.inner) @function.outer

(expr_call) @call.outer

(expr_call
  func_arguments: (fn_args
    (expr) @parameter.inner @parameter.outer))

(rule_args
  (term) @parameter.inner @parameter.outer)

(comment) @comment.outer
