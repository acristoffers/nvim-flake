; Function-like definitions
(list_lit
  .
  (sym_lit) @_fn
  (#any-of? @_fn "defn" "defn-" "defmacro" "defmethod" "definline" "defmulti" "fn" "fn*")) @function.outer

; Type-like definitions
(list_lit
  .
  (sym_lit) @_type
  (#any-of? @_type "defrecord" "deftype" "definterface" "defprotocol" "defstruct")) @class.outer

; Conditionals
(list_lit
  .
  (sym_lit) @_cond
  (#any-of? @_cond
    "if" "if-let" "if-not" "if-some" "when" "when-first" "when-let" "when-not" "when-some"
    "cond" "cond->" "cond->>" "condp" "case")) @conditional.outer

; Loops
(list_lit
  .
  (sym_lit) @_loop
  (#any-of? @_loop "loop" "for" "doseq" "dotimes" "while")) @loop.outer

; Calls
(list_lit
  .
  (sym_lit)) @call.outer

(list_lit
  .
  (sym_lit)
  .
  _* @call.inner)

; Parameters (binding vectors)
(vec_lit
  (sym_lit) @parameter.inner @parameter.outer)

; Comments
[
  (comment)
  (dis_expr)
] @comment.outer

; Statements / blocks
(list_lit
  "("
  .
  _+ @block.inner
  .
  ")") @block.outer

(list_lit) @statement.outer
