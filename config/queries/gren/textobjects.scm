(value_declaration
  body: (_) @function.inner) @function.outer

(anonymous_function_expr
  expr: (_) @function.inner) @function.outer

(function_declaration_left
  pattern: (_) @parameter.inner @parameter.outer)

(if_else_expr) @conditional.outer

(when_is_expr) @conditional.outer
(when_is_branch
  expr: (_) @conditional.inner) @conditional.outer

(let_in_expr
  body: (_) @block.inner) @block.outer

(function_call_expr) @call.outer
(function_call_expr
  arg: (_) @call.inner)

(type_declaration) @class.outer
(type_alias_declaration) @class.outer
(record_type
  (field_type) @parameter.outer)
(record_expr
  (field) @parameter.outer)
