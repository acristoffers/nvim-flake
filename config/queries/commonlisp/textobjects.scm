; Function-like definitions
(list_lit
  (defun_header) @_dh) @function.outer

(defun_header
  lambda_list: (list_lit
    (sym_lit) @parameter.inner @parameter.outer))

; Type-like definitions
(list_lit
  .
  (sym_lit) @_type
  (#any-of? @_type "defclass" "defstruct" "define-condition")) @class.outer

; Conditionals
(list_lit
  .
  (sym_lit) @_cond
  (#any-of? @_cond
    "if" "when" "unless" "cond" "case" "ccase" "ecase" "typecase" "ctypecase" "etypecase")) @conditional.outer

; Loops
(list_lit
  .
  (sym_lit) @_loop
  (#any-of? @_loop "loop" "do" "do*" "dotimes" "dolist")) @loop.outer

; Calls
(list_lit
  .
  (sym_lit)) @call.outer

(list_lit
  .
  (sym_lit)
  .
  _* @call.inner)

; Comments
[
  (comment)
  (block_comment)
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
