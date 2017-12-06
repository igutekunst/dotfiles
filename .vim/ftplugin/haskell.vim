
" Turn on line numbers:
set number
filetype plugin indent on

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env runhaskell % <CR>
