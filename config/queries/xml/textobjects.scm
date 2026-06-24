; XML element — outer includes the tags, inner is the element node
; (plugins typically strip the tags for inner via offset or child inspection)
(element) @element.outer
(element) @element.inner

; Single attribute including name, = and value
(attribute) @parameter.outer

; Attribute value only (the quoted string)
(attribute_value) @parameter.inner

; Entire start or self-closing tag (e.g. <foo bar="baz"> or <br/>)
(start_tag) @tag.outer
(empty_elem_tag) @tag.outer

; Tag name only
(tag_name) @tag.inner

; Comment block
(comment) @comment.outer
(comment) @comment.inner

; CDATA section
(cdata_sect) @cdata.outer
(cdata) @cdata.inner

; Processing instruction
(processing_instructions) @pi.outer
(pi_target) @pi.inner
