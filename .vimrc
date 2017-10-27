" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

noremap <C-n> :bnext<CR>
noremap <C-p> :bprev<CR>


" Use Vim settings
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  filetype indent on
  filetype plugin on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
	"improve autocomplete menu color
	highlight Pmenu ctermbg=238 gui=bold

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


set number


let mapleader = ","
autocmd FileType python map <F5> :w<CR>:!screen -x ipython -X stuff $'\%reset\ny\n\%cd %:p:h\n\%run %:t\n'<CR><CR>

filetype plugin on
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

if $VIM_CRONTAB == "true"
set nobackup
set nowritebackup
endif

if has("termguicolors")
set termguicolors
endif

colorscheme sunburst

" A bunch of things added
" from http://amix.dk/vim/vimrc.html
" Easy vimrc editing
"completes longest possible part,then lets you type more
set  wildmode=longest:full
set wildmenu "Turn on WiLd menu
" Automatically reload changed file
set autoread
" use mouse support
set mouse=a

" Searching
set ignorecase " ignore case when searching
set smartcase " Not really sure...

set nobackup
set nowb
set noswapfile
"Persistant undo
try
	if MySys() == "windows"
		set undodir=C:\Windows\Temp
	else
		set undodir=~/.vim_runtime/undodir
	endif

	set undofile
catch
endtry
"Tab Related stuff
set ts=4
set shiftwidth=4
"set expandtab " this should be moved into the python specific file
set smarttab

set lbr
set tw=500

"Auto Indent magic"
set ai "Auto  indent
set si "Smart indent
set wrap "Wrap lines... this could be sketch


"Visual  Mode Related tweaks
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('f')<CR>



map <leader>v :vsp <CR>
map <leader>h :sp <CR>

" Spelling

map <leader>ss :setlocal spell!<cr>
map <leader>r : source ~/.vimrc<cr>
map <leader>e :vsp! ~/.vimrc<cr>
map <leader>; <C-w>> <cr>
map <leader>E :sp! ~/.vimrc<cr>
map <leader>c :!ctags -R .<cr>

map <leader>R :redraw!<cr>

map <leader>h :%s/

map :Q<cr> :q<cr>


cmap <M-j> : ddp
cmap <M-k> : kddp

" Yank ring
" MRU Plugin Stuff
let MRU_Max_Entries = 400
set completeopt=longest,menu
"autocmd FileType python compiler pylint

au! BufRead,BufNewFile *.scad    set filetype=openscad " Should be split out into seperate file later
au BufRead,BufNewFile *.flo setfiletype flo

set tabstop=2
set softtabstop=2
set shiftwidth=2

set expandtab

scriptencoding utf-8
set encoding=utf-8



call plug#begin('~/.vim/plugged')

Plug 'gilligan/vim-lldb'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
"Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'ap/vim-css-color'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/sessionman.vim'
Plug 'tpope/vim-rhubarb'
Plug 'mtth/scratch.vim'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mbbil/undotree'
Plug 'vim-scripts/uptime.vim'


Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'

" Map :W to :w because fzf has a 
" :Windows command that keeps getting activated, driving me 
" up the wall!
command! W :w


nmap <Leader>t :Files<CR>
nmap <leader>b :Buffers<CR>

set mouse=a

if has('nvim')
  Plug 'neomake/neomake'
  :tnoremap <Esc> <C-\><C-n>
endif

call plug#end()

let g:colorscheme_switcher_exclude_builtins = 1

set guifont=Monaco\ for\ Powerline:h11
set guioptions=

let g:arline_symbols = "fancy"
let g:clang_user_options='|| exit 0'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set secure


" Enable the list of buffers

" Sweet pasting idea. use \ key
nmap \l :setlocal number!<CR>
nmap \o :set paste!<CR>
nmap \O :set paste!<CR>

" move around lines like a normal person
nmap j gj
nmap k gk
" Jump between buffers with Ctrl

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <leader>j V<CR>:%s/, /,\r/g<CR>

let g:color_coded_enabled = 1


" Deal with all the tab stuff
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>

nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR> nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>

nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

nmap \M :set expandtab! shiftwidth=4 tabstop=4 softtabstop=4<CR>
"chords

map <leader>a @

map <F3> :NERDTreeToggle<cr>

" Close scratch window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


"Invisible characters
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

nmap ccn :cnext <CR>
nmap ccp :cprev <CR>


nmap gn :tabn<CR>
nmap gp :tabp<CR>
nmap gt :tabnew<CR>

" Session Management
nmap gss :SessionSave <CR>
nmap gsl :SessionList <CR>
nmap gsa :SessionSaveAs 
nmap gsq :SessionClose <CR>

" Copy current file path to unamed register (paste with p)
:nmap cp :let @" = expand("%") <CR>

noremap <ScrollWheelUp> <C-Y><C-Y>
noremap <ScrollWheelDown> <C-E><C-E>



map <silent> <leader>d :bp\|bd<CR>

nnoremap <leader>u "uyiw :cscope find c @=u


" Convert #include "example.h" to #include <example.h>
map <leader>i V:s/#include[ ]*"\([a-z./]*\)"/#include <\1>/g<CR>


command! Todo :execute 'vimgrep /TODO\|FIXME/j'.' '.expand('%') | :copen | :cc


if !has('python')
echo "Error: Required vim compiled with +python"
    finish
endif

python << endpython
import vim, os, subprocess

def getUnstagedFiles():
    print "---------------------------------------------"
    output = subprocess.check_output('git ls-files -m'.split())
    output = output.splitlines()
    return output

endpython

function! LineNotes(name)

python << endpython
(row, col) = vim.current.window.cursor
relpath = vim.eval("expand('%')")
full = os.path.join(os.getcwd(), relpath)
(directory, filename) = os.path.split(full)
print directory, filename
unstaged = getUnstagedFiles()
if unstaged:
    vim.command(":e %s" % unstaged[0])


endpython
endfunction
map <leader>gun :call LineNotes(expand('%'))<CR>

" Remove annoying white space at end of lines
map <leader>cw :%s/[ \t]*$//g<CR>
" Remove ^Ms
map <leader>cr :%s/\r$// <CR>

" YouCompleteMe keybindings
map <leader>g :YcmCompleter GoTo<CR>
map <leader>j :YcmCompleter GetDoc<CR>
map <leader>f :YcmCompleter FixIt<cr>:w<cr>
map T :YcmCompleter GetType <CR>

if has('nvim')
    :tnoremap <A-h> <C-\><C-n><C-w>h
    :tnoremap <A-j> <C-\><C-n><C-w>j
    :tnoremap <A-k> <C-\><C-n><C-w>k
    :tnoremap <A-l> <C-\><C-n><C-w>l
    :nnoremap <A-h> <C-w>h
    :nnoremap <A-j> <C-w>j
    :nnoremap <A-k> <C-w>k
    :nnoremap <A-l> <C-w>l
endif

map =j :%!python -m json.tool<CR>

"Gradle
au BufNewFile,BufRead *.gradle setf groovy


" Fugitive vim
nnoremap <space>gb :Gblame<CR>


augroup filetypedetect
    au BufRead,BufNewFile *.dt setfiletype dts
    " associate *.foo with php filetype
augroup END


"set foldmethod=syntax
"set foldnestmax=10
"set nofoldenable
"set foldlevel=2
