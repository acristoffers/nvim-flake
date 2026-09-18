(function_definition
  (imperative_block)? @function.inner) @function.outer

(callback
  (imperative_block)? @function.inner) @function.outer

(callback_alias) @function.outer
(callback_event) @call.outer

(argument) @parameter.inner @parameter.outer

(struct_definition
  (struct_block)? @class.inner) @class.outer

(enum_definition
  (enum_block)? @class.inner) @class.outer

(component_definition) @class.outer
(component) @block.outer

(if_statement
  (imperative_block)? @conditional.inner) @conditional.outer
(if_expr) @conditional.outer

(for_loop
  (imperative_block)? @loop.inner) @loop.outer

(function_call) @call.outer

(comment) @comment.outer
