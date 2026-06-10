;; inherits: latex
;; extends

; Environments

(generic_environment
  begin: _
  .
  _+ @block.inner
  .
  end: _) @block.outer

(math_environment
  begin: _
  .
  _+ @block.inner
  .
  end: _) @block.outer

; Math
(displayed_equation
  .
  _+ @math.inner
  .) @math.outer

(inline_formula
  .
  _+ @math.inner
  .) @math.outer

(math_environment
  begin: _
  .
  _+ @math.inner
  .
  end: _) @math.outer

; Commands
(generic_command) @command.outer

(generic_command
  (curly_group
    "{"
    .
    _+ @command.inner
    .
    "}")
  .) @command.outer

(color_reference
  name: (curly_group_text text: _ @call.inner @command.inner) @call.outer) @command.outer

(color_reference
  name: (curly_group_text text: _ @call.inner) @call.outer
  text: (curly_group
    "{"
    .
    _+ @command.inner
    .
    "}")) @command.outer

(graphics_include        (curly_group_path path: _ @command.inner)) @command.outer
(class_include           (curly_group_path path: _ @command.inner)) @command.outer
(latex_include           (curly_group_path path: _ @command.inner)) @command.outer
(biblatex_include        (curly_group_glob_pattern pattern: _ @command.inner)) @command.outer
(title_declaration text: (curly_group _ @command.inner)) @command.outer
(label_definition  name: (curly_group_text text: _ @command.inner)) @command.outer

(new_command_definition
  declaration: (curly_group_command_name command: _ @call.inner) @call.outer
  implementation: (curly_group
    "{"
    .
    _+ @command.inner
    .
    "}")) @command.outer

(brack_group_key_value (key_value_pair) @parameter.inner) @parameter.outer

(subscript   subscript:   _ @subscript.inner) @subscript.outer
(superscript superscript: _ @superscript.inner) @superscript.outer

; Items
(enum_item
  .
  _+ @item.inner) @item.outer
