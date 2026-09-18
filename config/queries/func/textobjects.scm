(function_definition
  body: (block_statement) @function.inner) @function.outer

(parameter_declaration) @parameter.outer
(parameter_declaration
  (parameter) @parameter.inner)

(if_statement) @conditional.outer
(if_statement
  consequent: (block_statement) @conditional.inner)

(while_statement
  body: (block_statement) @loop.inner) @loop.outer

(repeat_statement
  body: (block_statement) @loop.inner) @loop.outer

(do_statement
  body: (block_statement) @loop.inner) @loop.outer

(try_statement) @conditional.outer

(function_application) @call.outer
(function_application
  arguments: (_) @call.inner)

(method_call) @call.outer
(method_call
  arguments: (_) @call.inner)

(comment) @comment.outer
