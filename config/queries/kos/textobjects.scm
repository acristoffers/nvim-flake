(function_decl) @function.outer

(class_decl) @class.outer

(class_member
  (function_decl) @function.outer)

(parameter
  parameter: (_) @parameter.inner) @parameter.outer

(for_statement) @loop.outer

(invocation) @call.outer

(comment) @comment.outer
