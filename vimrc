set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on     " required

call plug#begin('~/.vim/plugged')
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'majutsushi/tagbar'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'jnurmine/Zenburn'
  Plug 'Yggdroot/indentLine'
  Plug 'dyng/ctrlsf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'dense-analysis/ale'
  Plug 'davidhalter/jedi-vim', { 'do': 'pip install --user --no-cache-dir Flake8' }
  Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoUpdateBinaries' }
  Plug 'uarun/vim-protobuf'
call plug#end()

let mapleader = "\<Space>"

"" syntax
syntax on

set t_Co=256
colorscheme zenburn

set number
set cursorline
hi cursorline cterm=bold
set laststatus=2

"" After exiting vim, the content is displayed on the terminal screen
set t_ti= t_te=

"" encodings configure
set fileencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,latin1
set fileformats=unix,dos,mac

set wildmenu " Turn on WiLd menu
set wildmode=list:longest,list:full
set wildignore+=*.pyc,*.pyo,*/.git/*,*/node_modules/*

" set noswapfile
set directory=$HOME/.vim/swapfiles//

"" jump to the last position when reopening a file
if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"" make backspace work like most other apps
set backspace=2

"" set tabstop value and shift width
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hlsearch
set incsearch
hi IncSearch cterm=NONE ctermfg=NONE ctermbg=darkgrey
hi Search cterm=NONE ctermfg=NONE ctermbg=darkgrey

"" highlight ExtraWhitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/

"" complete option
set completeopt=menuone,longest

"" Cold Folding
set foldmethod=indent
set foldlevelstart=100
set foldlevel=99

"" Define custom indentation for filetypes
autocmd FileType javascript :setlocal sw=4 ts=4 sts=4
autocmd FileType less :setlocal sw=2 ts=2 sts=2
autocmd FileType json :setlocal sw=2 ts=2 sts=2
autocmd FileType yaml :setlocal sw=2 ts=2 sts=2

"" unite conf
nnoremap <leader>b :<C-u>Unite buffer<cr>
nnoremap <leader>f :<C-u>Unite -start-insert file<cr>
nnoremap <leader><space> :<C-u>Unite -start-insert file_rec<cr>
nnoremap gf :sp<cr> yaw :<C-u>Unite -start-insert file_rec<cr><C-r>"<ESC>

"" ale conf
map <leader>c :ALEToggle<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_python_flake8_options = "--ignore=E402,E128 --max-line-length=160"
let g:ale_linters = {'go': ['golangci-lint']}

"" indentLine
nnoremap <leader>i :IndentLinesToggle<cr>

"" nerdTree
let NERDTreeWinPos = 'right'
let NERDTreeWinSize = 32
map tr :NERDTreeToggle<cr>
let NERDTreeIgnore = ['.*\.pyc', '.*\.gitignore', '.DS_Store', '__pycache__']

"" tagbar
map tb :Tagbar<cr>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 26
let g:tagbar_left= 1

let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

"" airline
let g:airline_theme="luna"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0

"" jedi
let g:jedi#show_call_signatures = "1"

"" vim-go
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_def_mode = 'godef'

"" ctrlsf
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
