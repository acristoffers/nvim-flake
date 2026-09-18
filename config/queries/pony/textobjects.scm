[
  (class_definition)
  (actor_definition)
  (interface_definition)
  (trait_definition)
  (struct_definition)
  (primitive_definition)
] @class.outer

(method) @function.outer
(behavior) @function.outer
(constructor) @function.outer

(parameter
  name: (identifier) @parameter.inner @parameter.outer)

(lambda_parameter
  name: (identifier) @parameter.inner @parameter.outer)

[
  (if_statement)
  (iftype_statement)
  (match_statement)
  (try_statement)
] @conditional.outer

(repeat_statement) @loop.outer

(recover_statement) @block.outer

(call_expression) @call.outer

[
  (line_comment)
  (block_comment)
] @comment.outer
