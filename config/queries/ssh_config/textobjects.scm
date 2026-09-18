(host_declaration) @block.outer
(match_declaration) @block.outer

(parameter
  argument: (_) @parameter.inner) @parameter.outer

(comment) @comment.outer
