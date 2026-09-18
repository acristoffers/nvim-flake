(keyword_definition) @function.outer
(test_case_definition) @function.outer
(section) @class.outer

(for_statement) @loop.outer
(while_statement) @loop.outer

(if_statement) @conditional.outer
(inline_if_statement) @conditional.outer
(try_statement) @conditional.outer

(keyword_invocation) @call.outer

(keyword_invocation
  (arguments
    (argument) @parameter.inner @parameter.outer))

(comment) @comment.outer
