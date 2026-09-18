(function_declaration
  body: (statement_block
    .
    "{"
    _+ @function.inner
    "}")) @function.outer

(generator_function_declaration
  body: (statement_block
    .
    "{"
    _+ @function.inner
    "}")) @function.outer

(function_expression
  body: (statement_block
    .
    "{"
    _+ @function.inner
    "}")) @function.outer

(arrow_function
  body: (statement_block
    .
    "{"
    _+ @function.inner
    "}")) @function.outer

(arrow_function
  body: (_) @function.inner) @function.outer

(method_definition
  body: (statement_block
    .
    "{"
    _+ @function.inner
    "}")) @function.outer

(class_declaration
  body: (class_body
    .
    "{"
    _+ @class.inner
    "}")) @class.outer

(interface_declaration
  body: (_) @class.inner) @class.outer

(ui_object_definition
  (_)* @class.inner) @class.outer

(for_statement
  body: (statement_block
    .
    "{"
    _+ @loop.inner
    "}")) @loop.outer

(for_in_statement
  body: (statement_block
    .
    "{"
    _+ @loop.inner
    "}")) @loop.outer

(while_statement
  body: (statement_block
    .
    "{"
    _+ @loop.inner
    "}")) @loop.outer

(do_statement
  body: (statement_block
    .
    "{"
    _+ @loop.inner
    "}")) @loop.outer

(if_statement
  consequence: (statement_block
    .
    "{"
    _+ @conditional.inner
    "}")) @conditional.outer

(if_statement
  alternative: (else_clause
    (statement_block
      .
      "{"
      _+ @conditional.inner
      "}"))) @conditional.outer

(if_statement) @conditional.outer

(switch_statement
  body: (_)? @conditional.inner) @conditional.outer

(try_statement) @conditional.outer

(call_expression) @call.outer

(call_expression
  arguments: (arguments
    .
    "("
    _+ @call.inner
    ")"))

(statement_block
  (_)* @block.inner) @block.outer

(formal_parameters
  .
  (_) @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

(formal_parameters
  "," @parameter.outer
  .
  (_) @parameter.inner @parameter.outer)

(arguments
  .
  (_) @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

(arguments
  "," @parameter.outer
  .
  (_) @parameter.inner @parameter.outer)

; QML UI extensions
(ui_property) @parameter.outer
(ui_binding) @parameter.outer

(ui_signal
  (ui_signal_parameters
    (_) @parameter.inner @parameter.outer))

(ui_signal) @function.outer

(comment) @comment.outer

(return_statement
  (_) @return.inner) @return.outer

[
  (if_statement)
  (for_statement)
  (for_in_statement)
  (while_statement)
  (do_statement)
  (lexical_declaration)
  (return_statement)
] @statement.outer
