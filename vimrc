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
 set guifont=Courier_New:h9:cANSI 
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

