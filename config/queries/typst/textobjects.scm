(call (group)? @call.inner (content)? @call.inner) @call.outer

(group . (_) @parameter.inner @parameter.outer . ","? @parameter.outer)
(group "," @parameter.outer . (_) @parameter.inner @parameter.outer)
(heading (_) @parameter.inner)

(let) @statement.outer
(set) @statement.outer
(show) @statement.outer
(import) @statement.outer

(section (content) @section.inner) @section.outer

(branch condition: (_) @conditional.inner (content)? @conditional.inner (group)? @conditional.inner (block)? @conditional.inner) @conditional.outer

(for [pattern: (_) value: (_)] @loop.inner (content)? @loop.inner (group)? @loop.inne (block)? @loop.innerr) @loop.outer
(while condition: (_) @loop.inner (content)? @loop.inner (group)? @loop.inne (block)? @loop.innerr) @loop.outer

(item . _ _+ @_start @_end _* @_end (#make-range! @_start @_end "list_item.inner")) @list_item.outer
((item) (parbreak)?)+ @list.inner @list.outer

(math . (_)+ @_start @_end (_)* @_end (#make-range! @_start @_end "math.inner")) @math.outer

(attach sup: (_) @superscript.inner) @superscript.outer
(attach sub: (_) @subscript.inner) @subscript.outer
