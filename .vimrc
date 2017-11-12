" FOLLOWING IS REQUIRED FOR VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Keep Plugin commands between vundle#begin/end.
Plugin 'Valloric/YouCompleteMe'
" All of your Plugins must be added before the following line
" Examples at vundle documentation for adding plugins from diff kinds of sources
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" VUNDLE RELATED CODE ENDS

" change cursor to a vertical bar in insert mode, and non-blinking cursor
" block otherwise. 1: blinky block, 2; non-blinky block, 3:blinky underscore,
" 4: non-blinky underscore, 5: blinky vertical bar, 6: non-blinky vertical bar
au InsertEnter * silent execute "!echo -en \<esc>[5 q"
au InsertLeave * silent execute "!echo -en \<esc>[2 q"

" auto close different kind of brackets and have the cursor in between the
" brackets in insert mode
:inoremap ( ()<Esc>i
:inoremap { {}<Esc>i
:inoremap [ []<Esc>i

set cursorline " mark the line of the cursor
set colorcolumn=80 " line to mark 80th column
set tabstop=4 " one tab to appear as 4 spaces
set shiftwidth=4 " indents to appear as 4 spaces
set autoindent
set number " line numbers
