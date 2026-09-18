; functions
(function_item) @function.outer

(function_item
  body: (block
    .
    "{"
    _+ @function.inner
    "}"))

; structs, traits, impls and modules as classes
(struct_item) @class.outer

(struct_item
  body: (field_declaration_list
    .
    "{"
    _+ @class.inner
    "}"))

(enum_item) @class.outer

(enum_item
  body: (enum_variant_list
    .
    "{"
    _+ @class.inner
    "}"))

(trait_item) @class.outer

(trait_item
  body: (declaration_list
    .
    "{"
    _+ @class.inner
    "}"))

(impl_item) @class.outer

(impl_item
  body: (declaration_list
    .
    "{"
    _+ @class.inner
    "}"))

(mod_item) @class.outer

; conditionals
(if_expression
  alternative: (_
    (_) @conditional.inner)?) @conditional.outer

(if_expression
  alternative: (else_clause
    (block) @conditional.inner))

(if_expression
  condition: (_) @conditional.inner)

(if_expression
  consequence: (block) @conditional.inner)

(match_arm
  (_)) @conditional.inner

(match_expression) @conditional.outer

; loops
(while_expression
  body: (block
    .
    "{"
    _+ @loop.inner
    "}")) @loop.outer

(for_expression
  body: (block
    .
    "{"
    _+ @loop.inner
    "}")) @loop.outer

; blocks
(block
  (_)* @block.inner) @block.outer

; calls
(call_expression) @call.outer

(call_expression
  arguments: (arguments
    .
    "("
    _+ @call.inner
    ")"))

; statements
(block
  (_) @statement.outer)

; comments
(line_comment) @comment.outer

(block_comment) @comment.outer

; parameters
(parameters
  "," @parameter.outer
  .
  [
    (self_parameter)
    (parameter)
  ] @parameter.inner @parameter.outer)

(parameters
  .
  [
    (self_parameter)
    (parameter)
  ] @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

(closure_parameters
  "," @parameter.outer
  .
  (_) @parameter.inner @parameter.outer)

(closure_parameters
  .
  (_) @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

(arguments
  "," @parameter.outer
  .
  (_) @parameter.inner @parameter.outer)

(arguments
  .
  (_) @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)
