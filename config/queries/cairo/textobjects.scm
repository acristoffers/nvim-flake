; Functions
(function_definition
  (block) @function.inner) @function.outer

; Types
(struct_item
  (field_declaration_list) @class.inner) @class.outer

(struct_definition) @class.outer

(enum_item
  (enum_variant_list) @class.inner) @class.outer

(trait_item
  (declaration_list) @class.inner) @class.outer

(impl_item
  (declaration_list) @class.inner) @class.outer

(namespace_definition) @class.outer

; Loops
(loop_expression
  (block) @loop.inner) @loop.outer

; Conditionals
(if_statement
  (block) @conditional.inner) @conditional.outer

(if_expression) @conditional.outer

(match_expression
  (match_block) @conditional.inner) @conditional.outer

; Calls
(call_expression
  (arguments) @call.inner) @call.outer

; Parameters
(parameter) @parameter.inner @parameter.outer

; Comments
(comment) @comment.outer

; Statements
[
  (use_declaration)
  (let_declaration)
  (import_statement)
  (attribute_statement)
  (with_statement)
] @statement.outer

; Blocks
(block
  "{"
  .
  _+ @block.inner
  .
  "}") @block.outer
