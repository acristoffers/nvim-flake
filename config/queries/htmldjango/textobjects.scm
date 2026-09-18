; {% if %} ... {% elif %} ... {% else %} ... {% endif %}
((paired_statement
  .
  (tag_name) @_tag
  .
  _+ @conditional.inner
  .
  (end_paired_statement) .) @conditional.outer
  (#eq? @_tag "if"))

; {% for %} ... {% endfor %}
((paired_statement
  .
  (tag_name) @_tag
  .
  _+ @loop.inner
  .
  (end_paired_statement) .) @loop.outer
  (#eq? @_tag "for"))

[
  (paired_comment)
  (unpaired_comment)
] @comment.outer
