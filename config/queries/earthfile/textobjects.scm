; Targets / functions
(target
  (identifier)
  _+ @function.inner) @function.outer

; Loops
(for_command) @loop.outer

; Conditionals
(if_command) @conditional.outer
(try_command) @conditional.outer

; Blocks
(with_docker_command) @block.outer
(wait_command) @block.outer

; Calls (references to other targets/functions)
[
  (target_ref)
  (target_artifact)
  (function_ref)
] @call.outer

; Parameters
(build_arg
  (variable) @parameter.inner) @parameter.outer

; Comments
[
  (comment)
  (line_continuation_comment)
] @comment.outer
