(comment) @comment.outer

(interface_def
  (interface_body) @class.inner) @class.outer

[
  (struct_def)
  (union_def)
  (except_dcl)
  (module_dcl)
] @class.outer

(op_dcl
  (parameter_dcls) @function.inner) @function.outer

(param_dcl
  (simple_declarator) @parameter.inner @parameter.outer)

(member
  identifier: (declarators) @parameter.inner) @parameter.outer

(union_def
  (case_label) @conditional.outer)
