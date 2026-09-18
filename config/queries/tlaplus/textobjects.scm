(operator_definition) @function.outer
(function_definition) @function.outer
(module_definition) @function.outer

(operator_definition
  parameter: (_) @parameter.inner @parameter.outer)

(module_definition
  parameter: (_) @parameter.inner @parameter.outer)

(lambda
  (identifier) @parameter.inner @parameter.outer)

(choose
  (identifier) @parameter.inner @parameter.outer)

(module) @block.outer
(module) @block.inner

[
  (comment)
  (single_line)
  (block_comment)
] @comment.outer
