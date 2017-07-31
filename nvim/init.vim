" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

call plug#begin("~/.vim/plugged")

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'saltstack/salt-vim'  " Standard YAML formatting isn't enough
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'dag/vim-fish' , { 'for': 'fish' }
Plug 'ekalinin/Dockerfile.vim', { 'for': ['Dockerfile', 'docker-compose'] }
Plug 'mattn/emmet-vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'vim-scripts/groovy.vim'
Plug 'lumiliet/vim-twig'
Plug 'chikamichi/mediawiki.vim'
Plug 'tweekmonster/django-plus.vim'

if has('nvim')
    Plug 'neomake/neomake'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-jedi'
endif

call plug#end()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

let mapleader = ","

" Use the below if you care about security
" set modelines=0
" If you want modelines to work, this should be fine
set modelines=2

" Show line numbers and relative line numbers
set number
set relativenumber

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
if !has('nvim')
  set encoding=utf-8
endif

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
" nnoremap / /\v
" vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized


" My own customizations
" Clear highlighting; `:<backspace>` gets rid of lingering commands, it's used
" frequently
nnoremap <Space> :noh<CR>:<backspace>
" Quit insert mode with `jj`
inoremap jj <Esc>
" Save a file if there are changes with `,,`
nnoremap <leader>, :update<CR>
" Mouse selection needs to die...
set mouse-=a
" Toggle line numbers with `,tn`
nnoremap <leader>tn :set invnumber<CR> :se invrelativenumber<CR>
" Toggle paste
nnoremap <leader>tp :set invpaste<CR> <Space>
" Activate and deactivate nerdtree
nnoremap <leader>nt :NERDTreeToggle<CR>
" Activate and deactivate spelling
nnoremap <leader>ts :se invspell<CR>
"
" Buffer funs (<leader>b then things)

" Open buffers (<leader>bn then v or h)
nnoremap <leader>bnv :vsplit<CR>:<backspace>
nnoremap <leader>bnh :split<CR>:<backspace>

" Resize vertical buffers (<leader>brv)
function! ResizeVertical(amount)
  execute "vertical resize +" . a:amount
endfunction
nnoremap <leader>brv :<C-U>call ResizeVertical(v:count1)<CR>:<backspace>

" Resize horizontal buffers (<leader>brh)
function! ResizeHorizontal(amount)
  execute "resize +" . a:amount
endfunction
nnoremap <leader>brh :<C-U>call ResizeHorizontal(v:count1)<CR>:<backspace>

" Set pseudo-caps lock in insert mode with `CTRL-6`
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

" Neomake / QuickFix things
nnoremap <leader>qn :lnext<CR>:<backspace>
nnoremap <leader>qp :lprevious<CR>:<backspace>

" Plugin Customizations
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.swp$']

" Customize vim-markdown
let g:vim_markdown_folding_disabled = 1

" Ripped from Eli; see if this makes __pycache__ go away, then adapt from there
" let g:NERDChristmasTree = 1
" let g:NERDTreeCasadeOpenSingleChildDir = 1
" let g:NERDTreeChDirMode = 1
" let g:NERDTreeDirArrows = 0
" let g:NERDTreeDirArrows = 0
" let g:NERDTreeHijackNetrw = 1
" let g:NERDTreeIgnore = ['\.swp$', '\~$', '\.pyc', '__pycache__', '.DS_Store']
" let g:NERDTreeMinimalUI = 1
" let g:NERDTreeShowBookmarks = 1
" let g:NERDTreeShowFiles = 1
" let g:NERDTreeShowHidden = 1
" let g:NERDTreeShowLineNumbers = 0
" let g:NERDTreeWinSize = 22

" function! NERDTreeSettings()
"   nnoremap <silent> <Leader>nt :UndotreeHide<CR>:NERDTreeToggle<CR>
"   autocmd FileType nerdtree setlocal colorcolumn=""
" endfunction

" autocmd VimEnter * if exists(":NERDTree") | call NERDTreeSettings() | endif
autocmd BufRead,BufNewFile *.judo setfiletype json
autocmd BufRead,BufNewFile *.cyclops setfiletype json

" ======================
" Neomake
" ======================

function! NeomakeSettings()
    autocmd BufReadPost,BufWritePost * Neomake
    let g:neomake_open_list = 2
    let g:neomake_javascript_enabled_makers = ['eslint']
endfunction

autocmd VimEnter * if exists(":Neomake") | call NeomakeSettings() | endif


" =================
" Deoplete
" =================
function! DeopleteSettings()
    call deoplete#enable()
endfunction

let deoplete#sources#jedi#show_docstring = 1
if has("nvim")
    let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
    let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
endif

autocmd VimEnter * if has("nvim") | call DeopleteSettings() | endif
