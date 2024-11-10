;; inherits: c
;; extends

(switch_statement
  condition: (parenthesized_expression (_) @parameter.inner @parameter.outer)
  body: (compound_statement  "{" . _ @_start _? @_end . "}")
  (#make-range! "conditional.inner" @_start @_end)) @conditional.outer

((case_statement
   value: (_) @parameter.inner @parameter.outer
   . (_) @_start @_end (_)? @_end .)
 (#make-range! "conditional.inner" @_start @_end)) @conditional.outer

((case_statement !value
   . (_) @_start @_end (_)? @_end .)
 (#make-range! "conditional.inner" @_start @_end)) @conditional.outer
