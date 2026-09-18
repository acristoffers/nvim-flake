(function_definition
  block: (compound_statement) @function.inner) @function.outer

(parameter_list
  (parameter_declaration) @parameter.outer)
(parameter_declaration
  declarator: [
    (identifier)
    (array_declarator)
  ] @parameter.inner)

(struct_definition) @class.outer
(struct_definition
  fields: (_) @class.inner)

(if_statement) @conditional.outer
(if_statement
  consequence: (_) @conditional.inner)
(if_statement
  alternative: (else_clause
    (_) @conditional.inner))

(switch_statement
  block: (compound_statement) @conditional.inner) @conditional.outer

(case_statement) @conditional.outer

(while_statement
  consequence: (_) @loop.inner) @loop.outer

(do_statement
  consequence: (_) @loop.inner) @loop.outer

(for_statement
  consequence: (_) @loop.inner) @loop.outer

(call_expression) @call.outer
(call_expression
  arguments: (_) @call.inner)

(method_expression) @call.outer

(comment) @comment.outer
