(func_dialect) @function.outer

(func_arg_list
  (value_use) @parameter.inner @parameter.outer)

(block_arg_list
  (value_use) @parameter.inner @parameter.outer)

(generic_operation) @call.outer

(comment) @comment.outer
