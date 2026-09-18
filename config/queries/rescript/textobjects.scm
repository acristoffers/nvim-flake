(function) @function.outer

(let_binding
  body: (function)) @function.outer

(module_declaration) @class.outer
(type_declaration) @class.outer

(switch_expression) @conditional.outer

(block
  (_)* @block.inner) @block.outer

(call_expression) @call.outer

(parameter) @parameter.outer @parameter.inner
(labeled_parameter) @parameter.outer @parameter.inner

(comment) @comment.outer
