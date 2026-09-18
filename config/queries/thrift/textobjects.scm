(function_definition) @function.outer

(struct_definition) @class.outer
(union_definition) @class.outer
(exception_definition) @class.outer
(service_definition) @class.outer
(interaction_definition) @class.outer
(enum_definition) @class.outer

(parameter
  (identifier) @parameter.inner @parameter.outer)

(field
  (identifier) @parameter.inner @parameter.outer)

(comment) @comment.outer
