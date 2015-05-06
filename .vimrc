".vimrc
"Author: Viacheslav Lotsmanov

set nocompatible
filetype off "important for vundle

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

filetype plugin indent on "important for vundle

"vundle plugins
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'drmikehenry/vim-fontsize'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'gkz/vim-ls'
Plugin 'groenewege/vim-less'
Plugin 'wavded/vim-stylus'
Plugin 'digitaltoad/vim-jade'
Bundle 'chase/vim-ansible-yaml'
Plugin 'elzr/vim-json'
Plugin 'niklasl/vim-rdf'
Plugin 'klen/python-mode'
Bundle 'gmoe/vim-faust'
Plugin 'plasticboy/vim-markdown'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mattn/emmet-vim'
Plugin 'briancollins/vim-jst'
Plugin 'godlygeek/tabular'
Plugin 'bling/vim-airline'

"vundle colorschemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'darkburn'

"plugins stuff
let NERDTreeIgnore = ['\.swp', '\.swo', '\.pyc', '__pycache__']
let NERDTreeShowHidden = 1 "always show hidden files in NERDTree
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0

"load my modules
syntax on
runtime! my-modules/**/*.vim

"modules stuff
"highlight tabs by default
call ToggleTabsHL(1)

"some vim configs

set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set noexpandtab

set hlsearch
set smartcase

set nowrap
set number
set nocursorline
set nocursorcolumn
if v:version >= 703
	set colorcolumn=80
endif

if has('mouse')
	set mouse=a
endif

set fileencodings=utf8,cp1251
set modeline
set foldmethod=indent
set foldlevelstart=3
set cpoptions+=I "disable indent removing in insert mode

let mapleader = ','

"provide forward deleting in Insert and Command-Line modes
inoremap <C-l> <Del>
cnoremap <C-l> <Del>

"hotkeys
nmap <F1> <Esc>:tabnew<CR>
"reset search (removes hilighting)
nmap <F3> :let @/ = ""<CR>
"tabs
nmap <F4> <Esc><C-W><Right>:tabclose<CR>
nmap <F5> :NERDTreeMirrorToggle<CR>
nmap <F9> <Esc>:ToggleTabsHL<CR>
nmap <F10> <Esc>:DeleteHiddenBuffers<CR>

"custom digraphs
digraphs '' 769 "accent
digraphs 3. 8230 "dots

"vim: set noet :
