(declProc) @function.outer

(declProp) @function.outer

(declArg
  name: (identifier) @parameter.inner @parameter.outer)

(declType) @class.outer

(exprCall) @call.outer

(comment) @comment.outer
