; Functions
(function_declaration
  (block_statement) @function.inner) @function.outer

(constructor
  (block_statement) @function.inner) @function.outer

(destructor
  (block_statement) @function.inner) @function.outer

; Types
(class_declaration
  (aggregate_body) @class.inner) @class.outer

(struct_declaration
  (aggregate_body) @class.inner) @class.outer

(union_declaration
  (aggregate_body) @class.inner) @class.outer

(interface_declaration
  (aggregate_body) @class.inner) @class.outer

(enum_declaration) @class.outer

(template_declaration
  (aggregate_body) @class.inner) @class.outer

; Loops
(for_statement
  (block_statement) @loop.inner) @loop.outer

(foreach_statement
  (block_statement) @loop.inner) @loop.outer

(while_statement
  (block_statement) @loop.inner) @loop.outer

(do_statement
  (block_statement) @loop.inner) @loop.outer

; Conditionals
(if_statement
  (block_statement) @conditional.inner) @conditional.outer

(switch_statement) @conditional.outer

; Calls
(call_expression) @call.outer

; Parameters
(parameter) @parameter.inner @parameter.outer

; Comments
(comment) @comment.outer

; Statements
[
  (import_declaration)
  (variable_declaration)
  (module_declaration)
] @statement.outer

; Blocks
(block_statement
  "{"
  .
  _+ @block.inner
  .
  "}") @block.outer
