(mixin_definition) @function.outer
(mixin_use) @call.outer

(mixin_attributes
  (attribute_name) @parameter.inner @parameter.outer)

(conditional) @conditional.outer
(case) @conditional.outer

(each) @loop.outer
(while) @loop.outer

(tag) @block.outer

(comment) @comment.outer
