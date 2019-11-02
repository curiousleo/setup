set nocompatible              " be iMproved, required
filetype plugin on
syntax on

set autowrite
set wildmenu

set smartindent

set undolevels=1000

if !isdirectory($HOME . "/.vim/undo")
  call mkdir($HOME . "/.vim/undo", "p", 0700)
endif

set undodir=~/.vim/undo
set undofile

set title
