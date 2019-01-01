" vim-plug plugin manager utility.
" :PlugInstall to install the plugins; :PlugUpdate to update them
" :PlugClean will remove unused plugins, and :PlugUpgrade will update vim-plug itself
" Specify a directory for plugins
" Avoid using standard vim 'plugin' directory
call plug#begin('~/.vim/customPlugInLocation')

" Code completion engine. Fetches https://github.com/Valloric/YouCompleteMe.git
Plug 'valloric/YouCompleteMe'

" Initialize plugin system
" It will also automatically execute following commands
" filetype plugin indent on
" syntax enable
" You will need to explicitly disable these settings after plug#end(), if needed
" Do so, by adding following lines after plug#end()
" filetype indent off
" syntax off
call plug#end()

""" Cursor Style """
" Highlight the line where cursor is
set cursorline
" Set line numbers
set nu
" Color column 80
set colorcolumn=80
" change cursor to a vertical bar in insert mode, and non-blinking cursor
" block otherwise. 1: blinky block, 2; non-blinky block, 3:blinky underscore,
" 4: non-blinky underscore, 5: blinky vertical bar, 6: non-blinky vertical bar
au InsertEnter * silent execute "!echo -en \<esc>[6 q"
au InsertLeave * silent execute "!echo -en \<esc>[5 q"

""" Auto completing matching brackets """
inoremap {<CR>  {<CR>}<Esc>O
inoremap {      {}<Left>
inoremap (      ()<Left>
inoremap [      []<Left>
inoremap <      <><Left>
inoremap <<     <<<Space>
inoremap "      ""<Left>
inoremap '      ''<Left>

""" Indentation Settings """
" indentation without tabs
set expandtab
set shiftwidth=4
set softtabstop=4
" Enabling filetype based indentation explicitly
if has("autocmd")
    " Enable file type detection
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
endif
" custom indentation per filetype 
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

""" Color settings
highlight Search ctermfg=Black ctermbg=Red cterm=underline

""" Search settings """
set ignorecase " Ignore case by default
set incsearch " Enable incremental search. Shows matches as you type text to be searched
set hlsearch " highlight searched for phrases

""" Ease of use """
" Use F3 to toggle between paste mode and normal mode.
" Auto indent is disabled in paste mode. Useful as text to be pasted is mostly formatted already
set pastetoggle=<F3>
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif
" Make C-G display full path of a file
set statusline+=%F

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
