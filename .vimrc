
" Fixes vim background disappearing after scrolling using kitty "
let &t_ut=''

" Sets TAB size "
set tabstop=3

" Automatically detects file type for indentation "
filetype plugin indent on

" Adds colors depending on file type "
syntax on

" ENTER indent is the same as TAB "
set shiftwidth=3

" Allows to delete recently written stuff "
set backspace=2

" Shared clipboard with system "
set clipboard=unnamedplus

" Number of line in the left "
set number

" Calculates line distances and shows it in the left "
set relativenumber

" Highlights search "
set incsearch
set hlsearch

" Keymaps to change between splits using Alt+Arrow just like Ctrl+W+Arrow "
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

