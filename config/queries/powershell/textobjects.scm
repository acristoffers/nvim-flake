(function_statement) @function.outer

(class_statement) @class.outer

(class_method_definition) @function.outer

(class_method_parameter
  (variable) @parameter.inner @parameter.outer)

(script_parameter
  (variable) @parameter.inner @parameter.outer)

(switch_statement) @conditional.outer

(command) @call.outer
(invokation_expression) @call.outer

(comment) @comment.outer
