; Device nodes
(node
  "{"
  .
  _+ @block.inner
  .
  "}") @block.outer

; Properties
(property) @parameter.inner @parameter.outer

; Macro-like function definitions / calls
(preproc_function_def) @function.outer
(call_expression) @call.outer

(comment) @comment.outer
