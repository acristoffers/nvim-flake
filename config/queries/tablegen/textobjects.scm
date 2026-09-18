(class) @class.outer
(multiclass) @class.outer
(def) @class.outer
(defm) @class.outer
(defset) @class.outer

(template_arg
  (identifier) @parameter.inner @parameter.outer)

(foreach) @loop.outer

(if) @conditional.outer

(let) @statement.outer

[
  (comment)
  (multiline_comment)
] @comment.outer
