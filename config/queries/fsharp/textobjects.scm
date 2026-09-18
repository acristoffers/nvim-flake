(function_or_value_defn
  (function_declaration_left)) @function.outer

(argument_patterns) @parameter.outer
(argument_patterns
  (_) @parameter.inner)

(if_expression) @conditional.outer
(elif_expression) @conditional.outer
(match_expression) @conditional.outer
(try_expression) @conditional.outer

(for_expression) @loop.outer
(while_expression) @loop.outer

(application_expression) @call.outer

[
  (line_comment)
  (block_comment)
] @comment.outer
