;; inherits: go
;; extends

(expression_switch_statement
  value: (_) @parameter.inner @parameter.outer
  .
  [(expression_case) (default_case)]+ @conditional.inner
  .) @conditional.outer

(expression_case
  value: (_) @parameter.inner @parameter.outer
  .
  _+ @conditional.inner
  .) @conditional.outer

(default_case
  .
  _+ @conditional.inner
  .) @conditional.outer
