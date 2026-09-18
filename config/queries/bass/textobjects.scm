((list
   .
   (symbol) @_kw
   .
   (symbol)
   (symbol)? @parameter.inner @parameter.outer) @function.outer
  (#any-of? @_kw "def" "defop" "defn" "fn"))

((cons
   .
   (symbol) @_kw
   .
   (symbol)
   (symbol)? @parameter.inner @parameter.outer) @function.outer
  (#any-of? @_kw "def" "defop" "defn" "fn"))

((list
   .
   (symbol) @_kw
   .
   _+ @conditional.inner) @conditional.outer
  (#any-of? @_kw "if" "case" "cond" "when"))

((list
   .
   (symbol) @_kw
   .
   _+ @loop.inner) @loop.outer
  (#eq? @_kw "each"))

(list
  .
  (symbol) @call.inner) @call.outer

(comment) @comment.outer
