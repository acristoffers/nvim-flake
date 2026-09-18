; Starlark is a Python dialect; the shape below mirrors upstream
; nvim-treesitter-textobjects' python query, trimmed to constructs
; Starlark's grammar actually has (no classes, no decorators as scopes).

(function_definition
  body: (block)? @function.inner) @function.outer

(if_statement
  alternative: (_
    (_) @conditional.inner)?) @conditional.outer

(if_statement
  consequence: (block)? @conditional.inner)

(if_statement
  condition: (_) @conditional.inner)

(for_statement
  body: (block)? @loop.inner) @loop.outer

(while_statement
  body: (block)? @loop.inner) @loop.outer

(_
  (block) @block.inner) @block.outer

(comment) @comment.outer

(block
  (_) @statement.outer)

(module
  (_) @statement.outer)

(call) @call.outer

(call
  arguments: (argument_list
    .
    "("
    _+ @call.inner
    ")"))

(parameters
  .
  [
    (identifier)
    (default_parameter)
    (typed_parameter)
    (typed_default_parameter)
    (list_splat_pattern)
    (dictionary_splat_pattern)
  ] @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

(parameters
  "," @parameter.outer
  .
  [
    (identifier)
    (default_parameter)
    (typed_parameter)
    (typed_default_parameter)
    (list_splat_pattern)
    (dictionary_splat_pattern)
  ] @parameter.inner @parameter.outer)

(argument_list
  .
  (_) @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

(argument_list
  "," @parameter.outer
  .
  (_) @parameter.inner @parameter.outer)
