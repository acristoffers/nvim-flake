(comment) @comment.outer

(function_call
  .
  (identifier)
  .
  (arg)* @call.inner
  .) @call.outer

(arg) @parameter.outer @parameter.inner

(macro_statement
  (function_call) @function.inner) @function.outer

(for_statement) @loop.outer
(for_statement
  (in_expression) @loop.inner)

(if_expression) @conditional.outer
(if_expression
  (expression) @conditional.inner)

(raw_block
  (raw_body) @block.inner) @block.outer

[
  (block_statement)
  (filter_statement)
  (call_statement)
  (with_statement)
  (set_statement)
  (autoescape_statement)
  (trans_statement)
  (do_statement)
  (extends_statement)
  (import_statement)
  (include_statement)
  (pluralize_statement)
] @statement.outer
