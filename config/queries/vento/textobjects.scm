(if_block) @conditional.outer

(conditional_block) @conditional.inner

(else_block
  (conditional_block) @conditional.inner)

(else_if_block
  (conditional_block) @conditional.inner)

(for_block) @loop.outer

(function_block) @function.outer

(parameters) @function.inner

(parameter) @parameter.inner @parameter.outer

(set_block) @statement.outer

(export_block) @statement.outer

(layout_block) @block.outer

(fragment_block) @block.outer

(comment) @comment.outer
