(call_expression
  function: (_) @call.inner) @call.outer

(pipe_call
  arguments: (pipe_arguments) @call.inner) @call.outer
