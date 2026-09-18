(function_declaration
  (block) @function.inner) @function.outer

(defined_resource_type
  (block) @function.inner) @function.outer

(class_definition
  (block) @class.inner) @class.outer

(node_definition
  (block) @class.inner) @class.outer

(resource_declaration) @block.outer

(iterator_statement
  (block) @loop.inner) @loop.outer

(case_statement) @conditional.outer
(default_case) @conditional.inner

(parameter) @parameter.outer @parameter.inner
(attribute) @parameter.outer @parameter.inner

(comment) @comment.outer
