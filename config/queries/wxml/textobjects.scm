[
  (element)
  (block_element)
  (slot_element)
  (template_element)
] @block.outer

(start_tag
  (attribute) @block.inner)

(attribute) @parameter.outer

(attribute_value) @parameter.inner
(quoted_attribute_value) @parameter.inner

(comment) @comment.outer
