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
	"ruby
	autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
	autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
	autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
	autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
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
set t_Co=256
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
map <leader>f :YcmCompleter FixIt<cr>:w<cr>
"autocmd FileType python compiler pylint

au! BufRead,BufNewFile *.scad    set filetype=openscad " Should be split out into seperate file later
au BufRead,BufNewFile *.flo setfiletype flo

set tabstop=2
set softtabstop=2
set shiftwidth=2

set expandtab

scriptencoding utf-8
set encoding=utf-8


" 2013 May Plugin Stuff
" After adding Vim Addon Manager
"
"
"
"
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

let g:ctrlp_map = '<leader>t'
" Load all the plugins
"set runtimepath+=~/.vim/vim-addon-manager
"call vam#ActivateAddons(['vim-gitgutter', 'snipmate','ctrlp','surround', 'closetag', 'Syntastic','EasyMotion', 'fugitive','vim-coffee-script','The_NERD_tree'], {'auto_install' : 0})
"

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'bbchung/Clamp'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'ap/vim-css-color'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

let g:airline_powerline_fonts = 1
set guifont=Fira\ Mono\ Medium\ for\ Powerline:h9
let g:arline_symbols = "fancy"
let g:clang_user_options='|| exit 0'

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
"chords

map <leader>a @

map <F3> :NERDTreeToggle<cr>


" Close scratch window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" logging helpful commands

" set the log level to register v
map <leader>v V:s/LOG_[A-Z_]*/\=@v/g<CR>

" set register v
map <leader>sv viw"vy

" Set the log level in a line to
map <leader>vst V:s/LOG_[A-Z_]*/LOG_TRACE/g<CR>
map <leader>vsi V:s/LOG_[A-Z_]*/LOG_INFO/g<CR>
map <leader>vsw V:s/LOG_[A-Z_]*/LOG_WARNING/g<CR>
map <leader>vse V:s/LOG_[A-Z_]*/LOG_ERROR/g<CR>
map <leader>vsc V:s/LOG_[A-Z_]*/LOG_CRITICAL/g<CR>

map <leader>vc ct"
"Invisible characters
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬


" Git gutter features

" Form
" <leader>g <feature> <motion>

let g:gitgutter_diff_args = '--ignore-space-at-eol'
nmap <leader>ghn :GitGutterNextHunk<CR>
nmap <leader>ghp :GitGutterPrevHunk<CR>

nmap <leader>ghs :GitGutterStageHunk<CR>
nmap <leader>ghr :GitGutterRevertHunk<CR>




" NERD tree
nmap gn :tabn<CR>
nmap gp :tabp<CR>
nmap gt :tabnew<CR>

noremap <ScrollWheelUp> <C-Y><C-Y>
noremap <ScrollWheelDown> <C-E><C-E>



map <silent> <leader>d :bp\|bd<CR>

nnoremap <leader>u "uyiw :cscope find c @=u



map <leader>i V:s/#include[ ]*"\([a-z./]*\)"/#include <\1>/g<CR>

map <leader>c  ggO<ESC>gg:read ~/copy_header<CR>ggdd

if !has('python')
echo "Error: Required vim compiled with +python"
    finish
endif

python << endpython
import vim, os, subprocess

def getUnstagedFiles():
    print "---------------------------------------------"
    output = subprocess.check_output(['git', 'status'])
    output = output.splitlines()
    start = 0
    end = 0
    for i,line in enumerate(output):
        if line.startswith('#   (use "git checkout -- <file>..." to discard changes in working directory)'):
            start = i+2
        if start != 0 and i > start:
            if not line.startswith("#\t"):
                end = i -3
    if start:
        changed = [s[2:].split() for s in output[start:end]]
        changed = [(c[0][:-1], c[1]) for c in changed]
        print changed
        return changed
    else:
        return None

endpython

function! LineNotes(name)

python << endpython
(row, col) = vim.current.window.cursor
relpath = vim.eval("expand('%')")
full = os.path.join(os.getcwd(), relpath)
(directory, filename) = os.path.split(full)
next_file = getUnstagedFiles() [0]
if next_file:
    vim.command(":e %s" % next_file[1])


endpython
endfunction
map <leader>gun :call LineNotes(expand('%'))<CR>

" Remove annoying white space at end of lines
map <leader>cw :%s/[ \t]*$//g<CR>
" Remove ^Ms
map <leader>cr :%s/\r$// <CR>


map <leader>g :YcmCompleter GoTo<CR>

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
