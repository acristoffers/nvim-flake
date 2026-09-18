(clazz) @class.outer

(classMethod) @function.outer
(objectMethod) @function.outer

(parameterList
  (typedIdentifier) @parameter.inner @parameter.outer)

(objectBodyParameters
  (typedIdentifier) @parameter.inner @parameter.outer)

(qualifiedAccessExpr) @call.outer

[
  (lineComment)
  (blockComment)
] @comment.outer
