set rtp+=~/.vim "Put .vim on path so Windows same as Linux

"Lines that follow removed to install  tplugin
"source ~/.vim/autoload/pathogen.vim
"call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
 
"now source tplugin
source ~/.vim/bundle/tplugin_vim/macros/tplugin.vim
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

set number
 filetype plugin indent on
 syntax on
 set visualbell
 "Linux does not like this font
 " set guifont=Courier_New:h9:cANSI 
highlight Normal guibg=#CBF2C7

highlight LineNr guibg=lightgray guifg=black
"noremap i :highlight Normal guibg=#f8fab4<cr>i
"vunmap i
"noremap o :highlight Normal guibg=#f8fab4<cr>o
"noremap s :highlight Normal guibg=#f8fab4<cr>s
"noremap a :highlight Normal guibg=#f8fab4<cr>a
"vunmap a
"noremap I :highlight Normal guibg=#f8fab4<cr>I
"noremap O :highlight Normal guibg=#f8fab4<cr>O
"noremap S :highlight Normal guibg=#f8fab4<cr>S
"noremap A :highlight Normal guibg=#f8fab4<cr>A

"You need the next line to change the color back when you hit escape.
"inoremap <Esc> <Esc>:highlight Normal guibg=#CBF2C7<cr>

"Note: the color "Sys_Window" works for Windows only. 
"If running linux, use white or lightgrey instead.
set lines=40 columns=80
function! MoveLineUp()
  call MoveLineOrVisualUp(".", "")
endfunction

function! MoveLineDown()
  call MoveLineOrVisualDown(".", "")
endfunction

function! MoveVisualUp()
  call MoveLineOrVisualUp("'<", "'<,'>")
  normal gv
endfunction

function! MoveVisualDown()
  call MoveLineOrVisualDown("'>", "'<,'>")
  normal gv
endfunction

function! MoveLineOrVisualUp(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num - v:count1 - 1 < 0
    let move_arg = "0"
  else
    let move_arg = a:line_getter." -".(v:count1 + 1)
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualDown(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num + v:count1 > line("$")
    let move_arg = "$"
  else
    let move_arg = a:line_getter." +".v:count1
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualUpOrDown(move_arg)
  let col_num = virtcol(".")
  execute "silent! ".a:move_arg
  execute "normal! ".col_num."|"
endfunction

nnoremap <silent> <C-Up> :<C-u>call MoveLineUp()<CR>
nnoremap <silent> <C-Down> :<C-u>call MoveLineDown()<CR>
inoremap <silent> <C-Up> <C-o>:<C-u>call MoveLineUp()<CR>
inoremap <silent> <C-Down> <C-o>:<C-u>call MoveLineDown()<CR>
vnoremap <silent> <C-Up> :<C-u>call MoveVisualUp()<CR>
vnoremap <silent> <C-Down> :<C-u>call MoveVisualDown()<CR>
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
"Adjustment becuase I'm slow typing leader codes...
:set timeoutlen=2002 

nnoremap <silent> <C-a>  maggVG"+y`a
vnoremap <silent> <C-c>  "+y
"vnoremap <silent> <C-v>  "+p

"Finally got the colors to work the way I wanted
augroup hilite
:    au!
:    au InsertEnter * exe "highlight Normal guibg=#f8fab4"
:    au InsertLeave * exe "highlight Normal guibg=#CBF2C7"
augroup END

"Changes from http://biodegradablegeek.com/2007/12/using-vim-as-a-complete-ruby-on-rails-ide/
filetype on  " Automatically detect file types.
set nocompatible  " We don't want vi compatibility.
 
" Add recently accessed projects menu (project plugin)
set viminfo^=!
 
" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
 
" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>
 
" Change which file opens after executing :Rails command
"" Removed by MW let g:rails_default_file='config/database.yml'
 
syntax enable
set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
""REMOVED BY MW set nowrap  " Line wrapping off
"REMOVED BY MW set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
" colorscheme vividchalk  " Uncomment this to set a default theme
 
" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab
 
" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
"REMOVED BY MW :set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
 
" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes
set hlsearch
"Make sure MRU is initialized by starting, then closing it"
MRU
q
set history=700

" Fast editing of the .vimrc
map <leader>e :e! ~/.vim/vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim/vimrc
"Turn on the wildmenu for command completion"
set wildmenu

"Ignore case when searching, except when a capital lettter in string"
set ignorecase
set smartcase
"Research http://amix.dk/vim/vimrc.html for more hacks"

"Enable Ctrl-V and Ctrol-C cut and paste keys"
map <C-V> "+gP
cmap <C-V> <C-R>+
vnoremap <C-C> "+y
"research :http://www.slackorama.com/projects/vim/vimrc.html "
"From Dell
