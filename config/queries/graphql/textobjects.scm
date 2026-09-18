(operation_definition
  (selection_set) @function.inner) @function.outer

(fragment_definition
  (selection_set) @function.inner) @function.outer

(object_type_definition) @class.outer
(object_type_definition
  (fields_definition) @class.inner)

(interface_type_definition) @class.outer
(interface_type_definition
  (fields_definition) @class.inner)

(input_object_type_definition) @class.outer
(input_object_type_definition
  (input_fields_definition) @class.inner)

(field_definition) @parameter.outer
(input_value_definition) @parameter.outer
(argument) @parameter.outer

(field
  (arguments) @call.inner) @call.outer

(selection_set) @block.outer
(selection_set
  (selection) @block.inner)

(comment) @comment.outer
