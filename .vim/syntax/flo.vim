" Vim SYntax File
" Lanugae: flo
" Maintainer: Isaac Gutekunst
" Latest Revision: May 2013
"

if exists("b:current_syntax")
    finish
endif
" Keywords
syn keyword syntaxElementKeyword module keyword2 nextgroup=syntaxElement2

" Matches
syn match syntaxElementMatch 'regexp' contains=syntaxElement1 nextgroup=syntaxElement2 skipwhite


syn keyword flowBlockPieces module end endef define
syn keyword flowControl if else elif pass false true def endef

" Integer with - + or nothing in front
syn match celNumber '\d\+'
syn match celNumber '[-+]\d\+'

" Floating point number with decimal no E or e (+,-)
syn match celNumber '\d\+\.\d*'
syn match celNumber '[-+]\d\+\.\d*'

" Floating point like number with E and no decimal point (+,-)
syn match celNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match celNumber '\d[[:digit:]]*[eE][\-+]\=\d\+'

" Floating point like number with E and decimal point (+,-)
syn match celNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match celNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'


syn match floComment "--.*$" 


syn region flowModule start="module" end="end" fold transparent


let b:current_syntax = "flo"

hi def link floTodo             Todo
hi def link floComment          Comment
hi def link floHip              Type
hi def link floString           Constant
hi def link floDesc             PreProc
hi def link floNumber           Constant
hi def link flowBlockPieces     Statement
hi def link flowControl         Statement
