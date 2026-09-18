(method_definition
  block: (block) @function.inner) @function.outer

(closure
  block: (block) @function.inner) @function.outer

(class_definition
  implementation: (class_implementation) @class.inner) @class.outer

(struct_definition) @class.outer

(interface_definition
  implementation: (interface_implementation) @class.inner) @class.outer

(enum_definition) @class.outer

(if_statement
  block: (block) @conditional.inner
  else_block: (block)? @conditional.inner) @conditional.outer

(if_let_statement
  block: (block) @conditional.inner
  else_block: (block)? @conditional.inner) @conditional.outer

(else_if_block
  block: (block) @conditional.inner) @conditional.outer

(while_statement
  block: (block) @loop.inner) @loop.outer

(for_in_loop
  block: (block) @loop.inner) @loop.outer

(call
  args: (argument_list) @call.inner) @call.outer

(parameter_list
  (parameter_definition) @parameter.inner @parameter.outer)

(argument_list
  (_) @parameter.inner @parameter.outer)

(struct_field) @parameter.outer

(enum_field) @parameter.outer

(comment) @comment.outer
