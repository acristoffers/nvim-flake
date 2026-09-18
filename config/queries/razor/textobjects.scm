;; inherits: c_sharp
;; extends

(razor_if) @conditional.outer
(razor_switch) @conditional.outer
(razor_try) @conditional.outer
(razor_catch) @conditional.outer
(razor_finally) @conditional.outer

(razor_for) @loop.outer
(razor_foreach) @loop.outer
(razor_while) @loop.outer
(razor_do_while) @loop.outer

(razor_section) @block.outer
(razor_block) @block.outer
(razor_compound_using) @block.outer

[
  (razor_comment)
  (html_comment)
] @comment.outer
