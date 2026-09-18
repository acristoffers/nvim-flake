;; inherits: python
;; extends

(rule_definition) @function.outer
(module_definition) @function.outer
(checkpoint_definition) @function.outer

(rule_definition
  body: (_) @function.inner)
(module_definition
  body: (_) @function.inner)
(checkpoint_definition
  body: (_) @function.inner)

(directive
  name: (_) @parameter.outer)
