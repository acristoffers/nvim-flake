(list
  .
  (symbol) @_kw
  (#any-of? @_kw "defwidget" "defwindow" "defvar" "defpoll" "deflisten")
  (_)+ @function.inner
  .) @function.outer

(loop_widget
  (ast_block)+ @loop.inner) @loop.outer

(function_call) @call.outer

(function_call
  (simplexpr) @call.inner)

(list
  (ast_block) @parameter.inner @parameter.outer)

(comment) @comment.outer
