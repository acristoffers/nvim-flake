(func_def) @function.outer
(func_def
  (param_list
    (identifier) @parameter.inner @parameter.outer))

(func_call
  name: (_) @call.inner) @call.outer

(comment) @comment.outer
