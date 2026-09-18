(term_definition) @function.outer

(term_definition
  param: (_) @parameter.inner @parameter.outer)

(type_declaration) @class.outer

(ability_declaration) @class.outer

(ability_declaration
  (type_argument) @parameter.inner @parameter.outer)

(record
  (record_field) @parameter.outer) @class.outer

(record_field) @parameter.outer

(exp_if
  (if_block) @conditional.inner
  (then_block) @conditional.inner
  (else_block)? @conditional.inner) @conditional.outer

(match_expression) @conditional.outer

(pattern_case) @conditional.inner

(comment) @comment.outer
