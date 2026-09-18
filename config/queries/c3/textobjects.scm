; Functions / macros
(func_definition
  (compound_stmt) @function.inner) @function.outer

(macro_declaration
  (compound_stmt) @function.inner) @function.outer

; Types
(struct_declaration
  (struct_body) @class.inner) @class.outer

(bitstruct_declaration
  (bitstruct_body) @class.inner) @class.outer

(enum_declaration
  (enum_body) @class.inner) @class.outer

(interface_declaration
  (interface_body) @class.inner) @class.outer

; Loops
(for_stmt
  (compound_stmt) @loop.inner) @loop.outer

(foreach_stmt
  (compound_stmt) @loop.inner) @loop.outer

(while_stmt
  (compound_stmt) @loop.inner) @loop.outer

(do_stmt
  (compound_stmt) @loop.inner) @loop.outer

; Conditionals
(if_stmt
  (compound_stmt) @conditional.inner) @conditional.outer

(switch_stmt) @conditional.outer
(case_stmt) @conditional.outer
(default_stmt) @conditional.outer
(ct_if_stmt) @conditional.outer

; Calls
(call_expr
  (call_arg_list) @call.inner) @call.outer

; Parameters
(param) @parameter.inner @parameter.outer
(enum_param) @parameter.inner @parameter.outer

; Comments
[
  (line_comment)
  (block_comment)
  (doc_comment)
] @comment.outer

; Statements
[
  (expr_stmt)
  (declaration)
  (const_declaration)
  (return_stmt)
  (defer_stmt)
] @statement.outer

; Blocks
(compound_stmt
  "{"
  .
  _+ @block.inner
  .
  "}") @block.outer
