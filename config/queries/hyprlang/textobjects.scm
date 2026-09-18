(comment) @comment.outer

(section
  "{"
  .
  (_)* @block.inner
  .
  "}") @block.outer

(assignment
  (name) @parameter.outer)

[
  (assignment)
  (keyword)
  (declaration)
] @statement.outer
