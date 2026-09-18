(subprogram_body) @function.outer

(package_declaration) @class.outer
(package_body) @class.outer
(record_type_definition) @class.outer
(record_type_definition
  (record_definition) @class.inner)

(block_statement) @block.outer

(loop_statement) @loop.outer

(if_statement) @conditional.outer

(parameter_specification) @parameter.outer
(parameter_specification
  .
  (identifier) @parameter.inner)

(comment) @comment.outer
