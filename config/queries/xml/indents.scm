; Opening tag: indent content on following lines
(start_tag) @indent.begin

; Closing tag: dedent the tag line itself to match the opening tag
(end_tag) @indent.end

; DOCTYPE internal subset: indent declarations inside [...]
"[" @indent.begin
"]" @indent.end
