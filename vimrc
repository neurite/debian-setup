" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well.
set background=dark

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

set showcmd         " Show (partial) command in status line
set showmatch       " Show matching brackets
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all modes)

set autoindent nosmartindent

set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set number
set ruler
