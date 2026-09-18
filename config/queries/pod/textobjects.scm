(command_paragraph
  (command) @_head
  (#lua-match? @_head "^=head")) @section.outer

(verbatim_paragraph) @block.outer

(command_paragraph) @statement.outer
