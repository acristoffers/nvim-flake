(function_declaration) @function.outer
(primitive_declaration) @function.outer
(method_declaration) @function.outer

(class_declaration) @class.outer
(class_type) @class.outer
(record_type) @class.outer

(if_expression) @conditional.outer

(while_expression) @loop.outer
(for_expression) @loop.outer

(sequence_expression) @block.outer
(sequence_expression) @block.inner

(parameters
  name: (identifier) @parameter.inner @parameter.outer)

(function_call) @call.outer

(comment) @comment.outer
