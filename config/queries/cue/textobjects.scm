; Fields (label: value, possibly a nested struct)
(field) @block.outer

; Comprehensions / bindings
(for_clause) @loop.outer
(let_clause) @statement.outer

; Calls
(call_expression) @call.outer

; Comments
(comment) @comment.outer
