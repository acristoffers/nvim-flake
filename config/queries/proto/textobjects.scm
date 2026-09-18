(message
  (message_body) @class.inner) @class.outer

(enum
  (enum_body) @class.inner) @class.outer

(service) @class.outer
(oneof) @block.outer

(rpc) @function.outer

(field) @parameter.outer @parameter.inner
(oneof_field) @parameter.outer @parameter.inner
(enum_field) @parameter.outer @parameter.inner
(map_field) @parameter.outer @parameter.inner

(comment) @comment.outer
