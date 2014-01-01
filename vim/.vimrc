" Reference - https://github.com/mbrochh/vim-as-a-python-ide/blob/master/.vimrc
" Reference - http://www.unlogic.co.uk/posts/vim-python-ide.html

set nocompatible
filetype off

" Vundle - https://github.com/gmarik/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle - required!
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

filetype plugin indent on

" Rebind <Leader> key
let mapleader = ","

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END

" Powerline setup
" Need to setup fonts - https://github.com/Lokaltog/powerline-fonts
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>

" automatically change window's cwd to file's dir
set autochdir

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

" Quick quit command
noremap <Leader>q :quit<CR> " Quit current window
noremap <Leader>Q :qa!<CR> " Quit all windows

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim
" http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod

" Color line for max width of file
set colorcolumn=120
highlight ColorColumn ctermbg=233

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Disable auto comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" History
set history=50
set undolevels=500

" Case Insensitive Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
