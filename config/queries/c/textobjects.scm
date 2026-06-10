;; inherits: c
;; extends

(switch_statement
  condition: (_ (_) @parameter.inner @parameter.outer)
  body: (compound_statement
    "{"
    .
    _+ @conditional.inner
    .
    "}")) @conditional.outer

(case_statement
  value: (_) @parameter.inner @parameter.outer
  .
  _+ @conditional.inner
  .) @conditional.outer

(case_statement !value
  .
  _+ @conditional.inner
  .) @conditional.outer
