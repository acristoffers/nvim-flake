(func_def
  body: (_) @function.inner) @function.outer

(function
  parameters: (parameter_list) @parameter.outer)

(for_block) @loop.outer

(c_if) @conditional.outer

(comment) @comment.outer
