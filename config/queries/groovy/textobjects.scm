(function_definition
  body: (closure) @function.inner) @function.outer

(closure) @function.outer
(closure
  (_) @function.inner)

(class_definition) @class.outer

(parameter) @parameter.outer
(parameter
  name: (identifier) @parameter.inner)

(if_statement) @conditional.outer
(if_statement
  body: (_) @conditional.inner)
(if_statement
  else_body: (_) @conditional.inner)

(switch_statement
  body: (_) @conditional.inner) @conditional.outer

(try_statement) @conditional.outer

(while_loop
  body: (_) @loop.inner) @loop.outer

(do_while_loop
  body: (_) @loop.inner) @loop.outer

(for_loop
  body: (_) @loop.inner) @loop.outer

(for_in_loop
  body: (_) @loop.inner) @loop.outer

(function_call) @call.outer
(function_call
  args: (argument_list) @call.inner)

(comment) @comment.outer
