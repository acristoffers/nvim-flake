(comment) @comment.outer

(funcdef
  (query) @function.inner) @function.outer

(funcdefargs
  (identifier) @parameter.inner @parameter.outer)

(query
  .
  "if"
  .
  (query) @conditional.inner) @conditional.outer

(query
  .
  "try"
  .
  (query) @conditional.inner) @conditional.outer

(query
  .
  "reduce"
  .
  (_) @loop.inner) @loop.outer

(query
  .
  "foreach"
  .
  (_) @loop.inner) @loop.outer
