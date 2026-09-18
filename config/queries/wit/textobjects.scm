(interface_item
  (body) @class.inner) @class.outer

(world_item
  (body) @class.inner) @class.outer

(record_item
  (body) @class.inner) @class.outer

(variant_items
  (body) @class.inner) @class.outer

(flags_items
  (body) @class.inner) @class.outer

(enum_items
  (body) @class.inner) @class.outer

(resource_item
  (body)? @class.inner) @class.outer

(func_item) @function.outer

(resource_method) @function.outer

(param_list) @parameter.inner

(named_type
  name: (id) @parameter.inner) @parameter.outer

(record_field) @parameter.outer

[
  (line_comment)
  (block_comment)
] @comment.outer
