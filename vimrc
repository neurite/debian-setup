" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

syntax on
set background=dark
if has("autocmd")
  filetype plugin indent on
endif
set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
set mouse=a
set number
set ruler
set tabstop=4
set shiftwidth=4
set expandtab

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
