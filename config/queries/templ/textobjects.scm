;; inherits: go
;; extends

(component_declaration
  (component_block) @function.inner) @function.outer

(css_declaration) @function.outer
(script_declaration) @function.outer

(element) @block.outer
(element) @block.inner

(element_comment) @comment.outer
