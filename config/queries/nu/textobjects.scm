; functions
(decl_def) @function.outer
(decl_extern) @function.outer

(decl_def
  body: (block
    .
    "{"
    _+ @function.inner
    "}"
    .))

(val_closure) @function.outer

(val_closure
  parameters: (parameter_pipes)
  .
  _+ @function.inner
  .
  "}")

(val_closure
  !parameters
  .
  "{"
  _+ @function.inner
  "}"
  .)

; parameters
(parameter) @parameter.outer
(parameter
  param_name: (_) @parameter.inner)

(param_rest) @parameter.outer
(param_rest
  name: (_) @parameter.inner)

(param_opt) @parameter.outer
(param_opt
  name: (_) @parameter.inner)

; conditionals
(ctrl_if) @conditional.outer

(ctrl_if
  then_branch: (block
    .
    "{"
    _+ @conditional.inner
    "}"
    .))

(ctrl_if
  else_block: (val_closure
    parameters: (parameter_pipes)
    .
    _+ @conditional.inner
    .
    "}"))

(ctrl_if
  else_block: (val_closure
    !parameters
    .
    "{"
    _+ @conditional.inner
    "}"
    .))

(ctrl_match) @conditional.outer

(match_arm
  expression: (_) @conditional.inner)

(default_arm
  expression: (_) @conditional.inner)

(ctrl_try) @conditional.outer

(ctrl_try
  try_branch: (block
    .
    "{"
    _+ @conditional.inner
    "}"
    .))

(ctrl_try
  catch_branch: (val_closure
    parameters: (parameter_pipes)
    .
    _+ @conditional.inner
    .
    "}"))

(ctrl_try
  catch_branch: (val_closure
    !parameters
    .
    "{"
    _+ @conditional.inner
    "}"
    .))

; loops
(ctrl_for) @loop.outer
(ctrl_while) @loop.outer
(ctrl_loop) @loop.outer

(ctrl_for
  body: (block
    .
    "{"
    _+ @loop.inner
    "}"
    .))

(ctrl_while
  body: (block
    .
    "{"
    _+ @loop.inner
    "}"
    .))

(ctrl_loop
  body: (block
    .
    "{"
    _+ @loop.inner
    "}"
    .))

; calls
(command) @call.outer

(command
  arg: (_) @call.inner)

(command
  arg_str: (_) @call.inner)

; comments
(comment) @comment.outer
