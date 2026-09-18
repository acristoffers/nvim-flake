(function_statement) @function.outer
(sub_statement) @function.outer

(if_statement) @conditional.outer
(try_statement) @conditional.outer

(for_statement) @loop.outer
(while_statement) @loop.outer

(parameter
  name: (identifier) @parameter.inner) @parameter.outer

(function_call
  function: (_) @call.inner) @call.outer

(comment) @comment.outer
