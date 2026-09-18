(function_definition) @function.outer
(function_definition (parameters) @parameter.inner @parameter.outer)

(function_call) @call.outer
(parameters
  (identifier) @parameter.inner @parameter.outer)

(par) @loop.outer
(seq) @loop.outer
(sum) @loop.outer
(prod) @loop.outer

(comment) @comment.outer
