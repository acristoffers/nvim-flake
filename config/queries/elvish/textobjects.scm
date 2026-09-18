(function_definition) @function.outer
(parameter_list) @parameter.outer @parameter.inner

(if) @conditional.outer
(try) @conditional.outer

(while) @loop.outer
(for) @loop.outer

(command) @call.outer
(command argument: (_) @parameter.inner @parameter.outer)

(comment) @comment.outer
