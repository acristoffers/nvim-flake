(section
  (atx_heading) (_) @_start (_)* @_end .
  (#make-range! "section.inner" @_start @_end)) @section.outer

(list) @list.outer @list.inner

(list_item (_) (_) @list_item.inner) @list_item.outer
