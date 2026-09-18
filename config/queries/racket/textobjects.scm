(list
  .
  (symbol) @_head
  (#any-of? @_head "define" "define-values" "lambda" "λ" "define-syntax" "define-syntax-rule"
    "define-struct" "struct" "class" "class*")
  .
  (_)) @function.outer

(list
  .
  (symbol) @_head
  (#any-of? @_head "let" "let*" "letrec" "let-values" "let*-values" "let-syntax" "letrec-syntax"
    "parameterize")) @block.outer

(list
  .
  (symbol) @_head
  (#any-of? @_head "if" "cond" "case" "when" "unless" "match")) @conditional.outer

(list
  .
  (symbol) @_head
  (#any-of? @_head "for" "for*" "for/list" "for/or" "for/and" "for/sum" "for/vector" "for/hash" "do")) @loop.outer

(list
  .
  (symbol)
  .
  (_)+ @call.inner) @call.outer

(list) @block.outer

[
  (comment)
  (block_comment)
  (sexp_comment)
] @comment.outer
