;; inherits: latex
;; extends

; Environments

((generic_environment begin: _ . _ @_start _? @_end . end: _) @block.outer
  (#make-range! "block.inner" @_start @_end))

((math_environment begin: _ . _ @_start _? @_end . end: _) @block.outer
  (#make-range! "block.inner" @_start @_end))

; Math
((displayed_equation . _ @_start _? @_end .) @math.outer
 (#make-range! "math.inner" @_start @_end))

((inline_formula . _ @_start _? @_end .) @math.outer
 (#make-range! "math.inner" @_start @_end))

((math_environment begin: _ . _ @_start _? @_end . end: _) @math.outer
 (#make-range! "math.inner" @_start @_end))

; Commands
(generic_command) @command.outer
((generic_command (curly_group "{" . _ @_start _? @_end . "}") .) @command.outer
 (#make-range! "command.inner" @_start @_end))

((color_reference
   name: (curly_group_text text: _ @call.inner @command.inner) @call.outer) @command.outer)

((color_reference
   name: (curly_group_text text: _ @call.inner) @call.outer
   text: (curly_group "{" . _ @_start _? @_end . "}")) @command.outer
  (#make-range! "command.inner" @_start @_end))

(graphics_include        (curly_group_path path: _ @command.inner)) @command.outer
(class_include           (curly_group_path path: _ @command.inner)) @command.outer
(latex_include           (curly_group_path path: _ @command.inner)) @command.outer
(biblatex_include        (curly_group_glob_pattern pattern: _ @command.inner)) @command.outer
(title_declaration text: (curly_group _ @command.inner)) @command.outer
(label_definition  name: (curly_group_text text: _ @command.inner)) @command.outer

((new_command_definition
   declaration: (curly_group_command_name command: _ @call.inner) @call.outer
   implementation: (curly_group "{" . _ @_start _? @_end . "}")) @command.outer
 (#make-range! "command.inner" @_start @_end))

(brack_group_key_value (key_value_pair) @parameter.inner) @parameter.outer

(subscript   subscript:   _ @subscript.inner) @subscript.outer
(superscript superscript: _ @superscript.inner) @superscript.outer

; Items
((enum_item . _ @_start) @_end @item.outer
 (#make-range! "item.inner" @_start @_end))
