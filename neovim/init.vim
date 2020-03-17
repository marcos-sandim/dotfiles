" vim:foldmethod=marker:foldlevel=0
set shell=/bin/sh

" Plugins {{{
call plug#begin(stdpath('data') . '/plugged')

Plug '/usr/local/opt/fzf'

Plug '/home/sandim/.local/share/nvim/plugged-manual/cecutil'
Plug '/home/sandim/.local/share/nvim/plugged-manual/vis'

Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
" Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'preservim/nerdtree'
Plug 'svermeulen/vim-easyclip'

call plug#end()

packadd vimball

filetype off              " do not load $runtime/filetype.vim files
filetype plugin indent on " auto load plugin filetypes and indent specs
syntax on                 " enable syntax highlighting

let g:polyglot_disabled = ['latex']

" }}}

" Base Settings {{{

"set noerrorbells               " no beeps
set backspace=indent,eol,start " makes backspace key more powerful.
set clipboard=unnamedplus      " use X11 Clipboard
set autoread                   " automatically reread changed files without asking me anything
set fileformats=unix,dos,mac   " prefer Unix over Windows over OS 9 formats
set encoding=utf-8             " set default encoding to UTF-8
set ttyfast                    " improves performance of redrawing by signalizing a fast terminal connection
set wildmenu                   " show a menu for tab completion
set modeline                   " allow lines on extremities to contain vim config - `vim:foldmethod=marker:foldlevel=0`
set modelines=2                " amount of lines to check on extremities for modelines - 2 at least because of shebang

autocmd BufWritePre * %s/\s\+$//e

" }}}

" Cursor Configuration {{{

let &t_SI = "\<Esc>[6 q" " pipe on insert
let &t_SR = "\<Esc>[4 q" " underscore on replace
let &t_EI = "\<Esc>[2 q" " block on everything else

set whichwrap+=<,>,h,l,[,]

" }}}

" Rendering Settings {{{

set number         " show line numbers
set relativenumber " show line numbers relative to cursor position
set showcmd        " show me what I'm typing
set noshowmode     " show current mode.
set nowrap         " do not wrap long lines
set lazyredraw     " disables unnecessary redrawings, like on middle of macros
set laststatus=2   " controls whether to show the bottom status line
set showtabline=2  " always shows tab line independent of having more than one
set list           " show invisible characters
" invisible characters representation
set listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:%
" set listchars+=eol:¬,space:·
set listchars+=space:·

" }}}

" Split Settings {{{

set splitright " split vertical windows right to the current windows
set splitbelow " split horizontal windows below to the current windows

" }}}

" Tab & Folding Settings {{{

set expandtab " tabs are spaces
set shiftwidth=2 " number of spaces by indent
set tabstop=2 " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set foldenable      " enable folding
set foldmethod=indent " fold based on indent level
set foldlevelstart=5   " open 10 folds by default
set foldnestmax=10      " limits folds to 10

" }}}

" Searching Settings {{{

set noshowmatch " do not show matching brackets by flickering
set incsearch   " shows the match while typing
set hlsearch    " highlight found searches
set ignorecase  " search case insensitive...
set smartcase   " ... but not when search pattern contains upper case characters

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" }}}

" Color Settings {{{

"colorscheme base16
set nocursorcolumn " disable column hightlight
"set nocursorline  " disable line hightlight
call matchadd('ColorColumn', '\%81v') " hightlight characters at column 81

" }}}

" Completion Settings {{{

set completeopt=menuone,noinsert,preview

" }}}

" Key Mappings {{{

nnoremap <silent> <Space> :nohl<CR>
nnoremap <silent> <F5> :exe 'source '.stdpath('config').'/init.vim'<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :Rg<CR>
nnoremap <silent> <M-p> :Buffers<CR>

" EasyAlign {{{

" start interactive in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" start interactive for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}
" }}}

