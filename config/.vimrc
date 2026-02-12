"========================================================
"  Base
"========================================================

set nocompatible
filetype plugin indent on
syntax on

" Disable mouse 
set mouse=

" Make terminal Vim transparent
if &term =~ 'xterm\|rxvt\|alacritty\|kitty'
    highlight Normal ctermbg=none guibg=NONE
    highlight NonText ctermbg=none guibg=NONE
    highlight LineNr ctermbg=none guibg=NONE
    highlight EndOfBuffer ctermbg=none guibg=NONE
endif


"--------------------------------------------------------
" Colors & UI
"--------------------------------------------------------

match ErrorMsg '\s\+$'
autocmd ColorScheme * highlight Normal ctermbg=none guibg=NONE


"--------------------------------------------------------
" General Settings
"--------------------------------------------------------
set number
set ruler
set showcmd
set wildmenu
set hidden
set nowrap
set clipboard=unnamedplus
set history=1000


"--------------------------------------------------------
" Searching
"--------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch

" Use ripgrep if available
if executable('rg')
  set grepprg=rg\ --vimgrep
endif


"--------------------------------------------------------
" Tabs & Indentation
"--------------------------------------------------------
set expandtab        " Off for kernel style, but set explicitly
set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set autoindent
set cindent
set cinoptions=:0,l1,t0,g0,(0,W4
set textwidth=80
set colorcolumn=81
set formatoptions=croql


"--------------------------------------------------------
" C/C++ Specific Settings
"--------------------------------------------------------
augroup cdev
  autocmd!
  autocmd FileType c,cpp setlocal makeprg=make
  autocmd FileType c,cpp setlocal cindent
  autocmd FileType c,cpp setlocal formatoptions=croql
augroup END


"--------------------------------------------------------
" Code Navigation (ctags + cscope)
"--------------------------------------------------------
if has("cscope")
  set cscopetag
  set cscopeverbose
  set csto=1
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set cscopeprg=cscope
  if filereadable("cscope.out")
    cs add cscope.out
  endif
endif

nnoremap <leader>ct :!ctags -R --languages=C --exclude=.git .<CR>
nnoremap <leader>cs :!cscope -Rbq<CR>


"--------------------------------------------------------
" LSP / Clangd Integration
"--------------------------------------------------------
if executable('clangd')
  " Using vim-lsp or ALE
  " packadd vim-lsp
  augroup lsp_setup
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': ['clangd'],
          \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
          \ })
  augroup END
endif


"--------------------------------------------------------
" Mappings
"--------------------------------------------------------
let mapleader = ","

" Quick navigation
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>m :make<CR>
nnoremap <leader>g :grep! <C-R><C-W><CR>:cw<CR>

" Toggle highlight
nnoremap <leader>h :set hlsearch!<CR>


"--------------------------------------------------------
" Plugin Setup 
"--------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
" Shows errors, warnings, and formatting issues during type

Plug 'preservim/nerdtree'
" File explorer sidebar

Plug 'tpope/vim-fugitive'
" Git integration

Plug 'prabirshrestha/vim-lsp'
" Language Server Protocol client

Plug 'vim-airline/vim-airline'
" Status bar

call plug#end()

" NERDTree toggle
nnoremap <leader>n :NERDTreeToggle<CR>

" Tagbar
nnoremap <leader>t :TagbarToggle<CR>


"--------------------------------------------------------
" Status Line
"--------------------------------------------------------
set laststatus=2
set statusline=%f%m%r%h%w\ [%{&ff}]\ [POS=%04l,%04v]\ [%p%%]\ [%Y]

