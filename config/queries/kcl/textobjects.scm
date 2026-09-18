[
  (schema_stmt)
  (protocol_stmt)
  (rule_stmt)
] @class.outer

(schema_stmt
  body: (block) @class.inner)

(lambda_expr) @function.outer

(call_expr) @call.outer

(call_expr
  arguments: (argument_list) @call.inner)

(typed_parameter) @parameter.outer @parameter.inner

(comment) @comment.outer
