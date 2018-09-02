set exrc    " load project specific vimrc potentially present at vim invocation dir
set secure  " security option for non default vimrc files
call pathogen#infect() " Enable pathogen package manager 
call pathogen#helptags()

""" Search settings """
set ignorecase " Ignore case by default
set incsearch " Enable incremental search
set hlsearch " highlight searched for phrases

""" UI settings """
if has("mouse")
    set mouse=a
endif

""" Text editing """
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set history=50
set viminfo='100

""" Visual cues """
syntax on " syntax highlighting on
set ruler " show the cursor position
set showmatch " show matching brackets
set matchtime=5 " how many tenths of a second to blink matching brackets for
set scrolloff=5 " Keep 5 lines (top/bottom) for scope
set sidescrolloff=5 " Keep 5 lines at the size
set novisualbell " don't blink
set nu           " use line numbers

""" Color settings """
highlight Normal ctermfg=Black ctermbg=White
highlight Normal ctermfg=White ctermbg=Black
highlight Search ctermfg=Black ctermbg=Red cterm=underline

""" Indenting settings """
set colorcolumn=80
highlight ColorColumn ctermbg=blue
set softtabstop=4
set shiftwidth=4
set expandtab
set nosmartindent " smartindent (filetype indenting instead)
set autoindent
set cindent      
set cinoptions=g0:0 " No indent for public: or case:
set copyindent " but above all -- follow the conventions laid before us
filetype plugin indent on " load filetype plugins and indent settings

""" File type detection """
augroup filetypedetect
    au! BufRead,BufNewFile *.t setfiletype perl
augroup END

augroup Makefile
    au!
    au BufReadPre Makefile set noexpandtab
augroup END

""" Ease of use """
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif
" Make C-G display full path of a file
set statusline+=%F

""" Clipboard actions using vim yank and cut
set clipboard=unnamed

""" ctags
nnoremap <silent> <Leader>b :TagbarToggle<CR>
" Navigate up the directory tree to find tags file
set tags=./tags;/
" Ctrl-p => open tag definition in vertical spilt
map <C-p> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" C-o => open tag definition in horizontal spilt
map <C-o> :sp <CR>:exec("tag ".expand("<cword>"))<CR>
" Ctrl-\ => open tag definition in new tab
map <C-\> :tab split <CR>:exec("tag ".expand("<cword>"))<CR>

""" Following snippet provides ':Shell' command to run an external command
""" Usage: :Shell <external command with arguments>
""" The output of the external command is placed in a new horizontal buffer.
""" This was the main reason for copying this code, as this is the main
""" advantage over the native '!' command.
""" Another feature is that while in the output buffer, we can re run the
""" command using <localleader>r
""" Generally, <localeader> key is '\' 
function! s:ExecuteInShell(command)
let command = join(map(split(a:command), 'expand(v:val)'))
" check if buffer exists, otherwise create one
let winnr = bufwinnr('^' . command . '$')
silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
echo 'Execute ' . command . '...'
silent! execute 'silent %!'. command
"silent! execute 'resize ' . line('$')
silent! redraw
silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

" source $HOME/.vim/plugin/buildva.vim
