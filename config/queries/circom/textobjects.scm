; Functions / templates
(function_definition
  (function_body) @function.inner) @function.outer

(template_definition
  (template_body) @function.inner) @function.outer

(main_component_definition) @statement.outer

; Loops
(for_statement
  (block_statement)? @loop.inner) @loop.outer

(while_statement
  (block_statement)? @loop.inner) @loop.outer

; Conditionals
(if_statement
  (block_statement)? @conditional.inner) @conditional.outer

; Calls
(call_expression) @call.outer

; Parameters
(parameter) @parameter.inner @parameter.outer

; Comments
(comment) @comment.outer

; Blocks
(block_statement
  "{"
  .
  _+ @block.inner
  .
  "}") @block.outer
