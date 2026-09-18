;; inherits: c
;; extends

(class_interface) @class.outer
(class_implementation) @class.outer

(method_definition) @function.outer
(method_declaration) @function.outer

(method_parameter
  declarator: (identifier) @parameter.inner @parameter.outer)

(message_expression) @call.outer
