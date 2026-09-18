(value_declaration
  (decl_left
    (identifier_pattern))
  (expr_body
    (anon_fun_expr) @function.inner)) @function.outer

(argument_patterns
  (identifier_pattern
    (identifier)) @parameter.inner @parameter.outer)

(when_is_branch) @conditional.inner @conditional.outer

[
  (line_comment)
  (doc_comment)
] @comment.outer
