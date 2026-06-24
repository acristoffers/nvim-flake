(comment) @comment

[
  "DOCTYPE"
  "ELEMENT"
  "ATTLIST"
  "ENTITY"
  "NOTATION"
] @keyword

[
  "#REQUIRED"
  "#IMPLIED"
  "#FIXED"
  "#PCDATA"
] @keyword.directive

[
  "EMPTY"
  "ANY"
  "CDATA"
  "ID"
  "IDREF"
  "IDREFS"
  "NMTOKEN"
  "NMTOKENS"
  "ENTITIES"
] @constant.builtin

[
  "SYSTEM"
  "PUBLIC"
  "NDATA"
] @keyword

"xml" @keyword.directive

(doctype) @module
(element_name) @module
(attlist_name) @module
(notation_name) @module
(ndata_name) @module

(pi_target) @function.macro

(tag_name) @tag

[
  "encoding"
  "version"
  "standalone"
] @attribute.builtin

(attribute_name) @attribute

(attribute_value) @string
(system_literal) @string
(pubid_literal) @string
(entity_value) @string

(entity_ref) @character.special
(char_ref) @character.special
(pe_reference) @character.special

(cdata_sect) @markup.raw.block

[
  "<" "</" ">" "/>"
  "<?" "?>"
] @tag.delimiter

[
  "<!" "<![" "]]>"
  "[" "]"
] @punctuation.bracket

["="] @operator
["&" ";" "%"] @punctuation.special
