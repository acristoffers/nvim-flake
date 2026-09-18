(function_statement
  (function_body) @function.inner) @function.outer

(anon_function
  (function_body) @function.inner) @function.outer

(if_statement) @conditional.outer

(while_statement
  (while_body) @loop.inner) @loop.outer

(numeric_for_statement
  (for_body) @loop.inner) @loop.outer

(generic_for_statement
  (for_body) @loop.inner) @loop.outer

(repeat_statement) @loop.outer

(record_declaration) @class.outer
(enum_declaration) @class.outer

(arg
  name: (identifier) @parameter.inner @parameter.outer)

(function_call) @call.outer

(table_constructor) @block.outer
(table_constructor) @block.inner

(comment) @comment.outer
