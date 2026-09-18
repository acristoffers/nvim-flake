(subroutine
  .
  (subroutine_statement)
  .
  (_)* @function.inner
  .
  (end_subroutine_statement)
  .) @function.outer

(function
  .
  (function_statement)
  .
  (_)* @function.inner
  .
  (end_function_statement)
  .) @function.outer

(if_statement) @conditional.outer
(select_case_statement) @conditional.outer
(where_statement) @conditional.outer

(do_loop_statement) @loop.outer

(call_expression
  (argument_list)? @call.inner) @call.outer

(argument_list
  (_) @parameter.inner @parameter.outer)

(comment) @comment.outer
