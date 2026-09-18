;; inherits: c
;; extends

[
  (foreach_statement)
  (foreach_instance_statement)
] @loop.outer

(foreach_statement
  body: (compound_statement
    .
    "{"
    _+ @loop.inner
    "}")) @loop.outer

(foreach_instance_statement
  body: (compound_statement
    .
    "{"
    _+ @loop.inner
    "}")) @loop.outer
