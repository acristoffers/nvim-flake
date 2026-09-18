(model_statement
  (model_expression
    (model_body) @class.inner)) @class.outer

(interface_statement
  (interface_body) @class.inner) @class.outer

(enum_statement
  (enum_body) @class.inner) @class.outer

(union_statement
  (union_body) @class.inner) @class.outer

(namespace_statement
  (namespace_body) @class.inner) @class.outer

(operation_statement) @function.outer

(function_declaration_statement
  (function_parameter_list) @function.inner) @function.outer

(function_parameter
  name: (identifier) @parameter.inner) @parameter.outer

(model_property) @parameter.outer

(operation_arguments
  (model_property
    name: (identifier) @parameter.inner)) @parameter.outer

(decorator) @call.outer

(decorator
  (decorator_arguments) @call.inner)

[
  (single_line_comment)
  (multi_line_comment)
] @comment.outer
