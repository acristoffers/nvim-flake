(comment) @comment.outer

(anonymous_function
  body: (_) @function.inner) @function.outer

(params
  (param) @parameter.inner @parameter.outer)

(functioncall
  (args) @call.inner) @call.outer

(conditional
  consequence: (_) @conditional.inner) @conditional.outer

(conditional
  alternative: (_) @conditional.inner)

(forloop) @loop.outer

(forspec) @loop.inner

(field
  (fieldname) @parameter.outer) @parameter.outer

(object
  (member) @class.inner) @class.outer
