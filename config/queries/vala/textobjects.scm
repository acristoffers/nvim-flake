(method_declaration
  (block) @function.inner) @function.outer

(local_function_declaration
  (block) @function.inner) @function.outer

(lambda_expression
  (block)? @function.inner) @function.outer

(constructor_declaration
  (block) @function.inner) @function.outer

(destructor_declaration
  (block) @function.inner) @function.outer

(class_declaration) @class.outer

(struct_declaration) @class.outer

(interface_declaration) @class.outer

(enum_declaration) @class.outer

(errordomain_declaration) @class.outer

(if_statement
  (block) @conditional.inner) @conditional.outer

(else_statement
  (block) @conditional.inner) @conditional.outer

(elseif_statement
  (block) @conditional.inner) @conditional.outer

(switch_statement
  (switch_section) @conditional.inner) @conditional.outer

(while_statement
  (block) @loop.inner) @loop.outer

(for_statement
  (block) @loop.inner) @loop.outer

(foreach_statement
  (block) @loop.inner) @loop.outer

(do_statement
  (block) @loop.inner) @loop.outer

(method_call_expression
  (argument) @call.inner) @call.outer

(object_creation_expression) @call.outer

(parameter) @parameter.inner @parameter.outer

(argument) @parameter.inner @parameter.outer

(field_declaration) @statement.outer

(local_declaration) @statement.outer

(comment) @comment.outer
