(user_defined_function) @function.outer
(lambda_expression) @function.outer

(resource_declaration) @class.outer
(module_declaration) @class.outer
(type_declaration) @class.outer

(parameter_declaration) @parameter.outer
(parameter_declaration
  (identifier) @parameter.inner)
(parameter
  .
  (identifier) @parameter.inner) @parameter.outer

(for_statement) @loop.outer

(if_statement) @conditional.outer

(call_expression
  function: (_) @call.inner) @call.outer

[
  (comment)
  (diagnostic_comment)
] @comment.outer
