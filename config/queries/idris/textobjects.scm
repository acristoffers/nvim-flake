(comment) @comment.outer

(function
  (rhs) @function.inner) @function.outer

(data
  (data_body) @class.inner) @class.outer

[
  (interface_head)
  (implementation_head)
] @class.outer

(exp_case) @conditional.outer

(pat_name
  (loname) @parameter.inner @parameter.outer)
