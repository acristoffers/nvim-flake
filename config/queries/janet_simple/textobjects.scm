(comment) @comment.outer

(short_fn_lit) @function.outer

((par_tup_lit
  .
  (sym_lit) @_head
  .
  _+ @function.inner
  .) @function.outer
  (#any-of? @_head "defn" "defn-" "fn" "defmacro" "defmacro-" "varfn"))

((par_tup_lit
  .
  (sym_lit) @_head
  .
  _+ @conditional.inner
  .) @conditional.outer
  (#any-of? @_head "if" "when" "unless" "cond" "case" "match" "if-let" "when-let" "if-not" "if-with" "when-with"))

((par_tup_lit
  .
  (sym_lit) @_head
  .
  _+ @loop.inner
  .) @loop.outer
  (#any-of? @_head "while" "loop" "for" "each" "eachk" "eachp" "forv" "seq" "generate" "repeat" "forever" "catseq" "tabseq"))

(par_tup_lit
  .
  (sym_lit)
  .
  _+ @call.inner
  .) @call.outer
