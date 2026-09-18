(function_definition) @function.outer
(python_function_definition) @function.outer
(anonymous_python_function) @function.outer

(if_statement) @conditional.outer
(try_statement) @conditional.outer

(for_statement) @loop.outer
(while_statement) @loop.outer

(call
  function: (_) @call.inner) @call.outer

(parameters
  (python_identifier) @parameter.inner @parameter.outer)
(lambda_parameters
  (python_identifier) @parameter.inner @parameter.outer)
(default_parameter
  name: (python_identifier) @parameter.inner) @parameter.outer
(typed_parameter
  (python_identifier) @parameter.inner @parameter.outer)
(typed_default_parameter
  (python_identifier) @parameter.inner @parameter.outer)
