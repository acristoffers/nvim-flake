(configuration_block
  (block
    (block_inner_content) @block.inner)) @block.outer

(condition_block) @conditional.outer

(condition) @conditional.outer

(symfony_function_call) @call.outer

(symfony_method_call) @call.outer

(symfony_function_parameter) @parameter.inner @parameter.outer

(symfony_method_parameter) @parameter.inner @parameter.outer

(assignment_line) @statement.outer

[
  (comment)
  (single_line_comment)
] @comment.outer
