" Turn on line numbers:
set number
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
filetype plugin indent on


" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env ruby % <CR>
