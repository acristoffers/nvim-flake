;; inherits: go
;; extends

(expression_switch_statement
  value: (_) @parameter.inner @parameter.outer
  . [(expression_case) (default_case)] @_start [(expression_case) (default_case)]? @_end .
  (#make-range! "conditional.inner" @_start @_end)) @conditional.outer

((expression_case
   value: (_) @parameter.inner @parameter.outer
   . (_) @_start @_end (_)? @_end .)
 (#make-range! "conditional.inner" @_start @_end)) @conditional.outer

((default_case
   . (_) @_start @_end (_)? @_end .)
 (#make-range! "conditional.inner" @_start @_end)) @conditional.outer
