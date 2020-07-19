" vim:foldmethod=marker:foldlevel=0
set shell=/bin/sh

" Function to source only if file exists {{{
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }}}

" Plugins {{{
call plug#begin(stdpath('data') . '/plugged')

Plug '/usr/local/opt/fzf'

Plug '~/.local/share/nvim/plugged-manual/vis'

" Plug 'ap/vim-buftabline'
" Plug 'arp242/confirm_quit.vim'
" Plug 'dense-analysis/ale'
" Plug 'junegunn/vim-easy-align'
" Plug 'svermeulen/vim-easyclip'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-vinegar'
Plug 'APZelos/blamer.nvim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'chriskempson/base16-vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'skywind3000/gutentags_plus'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'

call plug#end()

packadd vimball

filetype off              " do not load $runtime/filetype.vim files
filetype plugin indent on " auto load plugin filetypes and indent specs
syntax on                 " enable syntax highlighting
set nocompatible
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
set hidden

command! -bar MTrimWhiteSpace %s/\s\+$//e
autocmd BufWritePre * MTrimWhiteSpace

let NERDTreeShowHidden=1
let g:blamer_enabled=1
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
set listchars+=eol:¬,space:·
" set listchars+=space:·

" }}}

" Neovide {{{

set guifont=Fira\ Code:h12
let g:neovide_cursor_animation_length=0.1
let g:neovide_cursor_trail_length=8.0
let g:neovide_cursor_vfx_mode = "railgun"
let g:neovide_refresh_rate=60

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
set foldlevelstart=5   " open 5 folds by default
set foldnestmax=10      " limits folds to 10

" }}}

" Searching Settings {{{

set noshowmatch " do not show matching brackets by flickering
set incsearch   " shows the match while typing
set hlsearch    " highlight found searches
set ignorecase  " search case insensitive...
set smartcase   " ... but not when search pattern contains upper case characters

command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --no-ignore-vcs --hidden --smart-case '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" }}}

" Color Settings {{{

colorscheme base16-default-dark
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

" }}}

" EasyAlign {{{

" start interactive in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" start interactive for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}

" DadBod {{{

call SourceIfExists("~/.config/nvim/dadbods.vim")

function! s:DBSelected(id)
  echomsg 'selected: ' . a:id
  if a:id != -1
    let t = filter(copy(g:dadbods), 'v:val.name == a:id')[0]
    let b:db = t.url
    echomsg 'DB ' . t.name . ' is selected.'
  endif
endfunc

command! DBSelect :call fzf#run({
      \ 'source': map(copy(g:dadbods), {k, v -> v.name}),
      \ 'sink': function('s:DBSelected')
      \} )

xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)

nmap <leader>p vip<leader>db<CR>
"
" }}}

" Startify {{{

call SourceIfExists("~/.config/nvim/startify_bookmarks.vim")

let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

" autocmd VimEnter *
"             \   if !argc()
"             \ |   Startify
"             \ |   NERDTree
"             \ |   wincmd w
"             \ | endif

" }}}

" Lightline {{{

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" }}}

" Gutentags {{{

" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" }}}

" VimWiki {{{

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" }}}

" FZF {{{
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))
" }}}

" {{{

let g:vimtex_compiler_progname = 'nvr'

" }}}

" LSP {{{
let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }
" }}}
