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
" Mappings
"--------------------------------------------------------
let mapleader = ","

" Quick navigation
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

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

" ============================
" Go: Autocompletion (ALE)
" ============================
let g:ale_completion_enabled = 1
set completeopt=menu,menuone,noselect

" ============================
" Go: Linting
" ============================
let g:ale_linters = {
\   'go': ['gopls', 'golangci-lint', 'govet'],
\}

" Run linting only on save (optional)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1

" ============================
" Go: Formatting
" ============================
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'go': ['gofmt', 'goimports'],
\}
