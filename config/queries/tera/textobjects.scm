(macro_statement) @function.outer

(macro_statement
  (parameter_list
    parameter: (identifier) @parameter.inner @parameter.outer))

(call_expression) @call.outer

(comment_tag) @comment.outer
