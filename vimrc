set rtp+=~/.vim
source ~/.vim/autoload/pathogen.vim
call pathogen#runtime_append_all_bundles()
 call pathogen#helptags()
 set number
 filetype plugin indent on
 syntax on
 set visualbell
 set guifont=Courier_New:h9:cANSI 
highlight Normal guibg=#CBF2C7

noremap i :highlight Normal guibg=#f8fab4<cr>i
noremap o :highlight Normal guibg=#f8fab4<cr>o
noremap s :highlight Normal guibg=#f8fab4<cr>s
noremap a :highlight Normal guibg=#f8fab4<cr>a
noremap I :highlight Normal guibg=#f8fab4<cr>I
noremap O :highlight Normal guibg=#f8fab4<cr>O
noremap S :highlight Normal guibg=#f8fab4<cr>S
noremap A :highlight Normal guibg=#f8fab4<cr>A

"You need the next line to change the color back when you hit escape.
noremap <Esc> <Esc>:highlight Normal guibg=#CBF2C7<cr>

"Note: the color "Sys_Window" works for Windows only. 
"If running linux, use white or lightgrey instead.
set lines=40 columns=80
