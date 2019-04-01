set directory=~/.vim/backup
set backupdir=~/.vim/backup " keep swap files here
filetype off                " required

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'                                                    " git plugin
Plug 'vim-airline/vim-airline'                                               " bottom status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }            " fuzzy finder conf
Plug 'junegunn/fzf.vim'                                                      " fuzzy finder
Plug 'scrooloose/nerdtree'                                                   " folders tree
Plug 'scrooloose/nerdcommenter'                                              " code commenter
Plug 'dracula/vim'                                                           " dark theme
Plug 'kien/rainbow_parentheses.vim'                                          " for nested parentheses
Plug 'tpope/vim-surround'                                                    " quickly edit surroundings (brackets, html tags, etc)
Plug 'junegunn/vim-easy-align'                                               " alignment plugin
Plug 'neomake/neomake'                                                       " run programs asynchronously and highlight errors
Plug 'Valloric/MatchTagAlways'                                               " highlights html enclosing tags
Plug 'natebosch/vim-lsc'                                                     " LSP client
Plug 'Twinside/vim-hoogle'                                                   " Hoogle search (Haskell) in Vim
Plug 'Shougo/unite.vim'                                                      " Required by some haskell plugins
Plug 'ujihisa/unite-haskellimport'                                           " Suggestions on imports
Plug 'eagletmt/unite-haddock'                                                " Hoogle results on the Vim buffer
Plug 'vmchale/dhall-vim'                                                     " Syntax highlighting for Dhall lang
Plug 'terryma/vim-multiple-cursors'                                          " Multiple cursors selection, etc

"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}       " autocompletion plugin
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }                " autocompletion plugin
"Plug 'zxqfl/tabnine-vim'                                                     " autocompletion plugin

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }                                                                      " LSP plugin for Haskell Ide Plugin (hie)

" Plug 'easymotion/vim-easymotion'
" Plug 'tpope/vim-repeat'

" Plug 'Xuyuanp/nerdtree-git-plugin'                              " Shows files git status on the NerdTree
" Plug 'neovimhaskell/haskell-vim'
" Plug 'eagletmt/neco-ghc'
Plug 'derekwyatt/vim-scala'                                     " scala plugin

call plug#end()

" End of plugins here
" ===================

" Use deoplete
"let g:python3_host_prog = '/usr/bin/python3'
"let g:deoplete#enable_at_startup = 1

" airline: status bar at the bottom
let g:airline_powerline_fonts=1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

" Neomake on save
" autocmd! BufWritePost * Neomake

" Nerd commenter
filetype plugin on

" Better Unix support
set viewoptions=folds,options,cursor,unix,slash
set encoding=utf-8

" Handle window actions with Meta instead of <C-w>
" Switching
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Moving
nnoremap <M-H> <C-w>H
nnoremap <M-J> <C-w>J
nnoremap <M-K> <C-w>K
nnoremap <M-L> <C-w>L
nnoremap <M-x> <C-w>x

" Resizing
nnoremap <M-=> <C-w>=
nnoremap <M-+> <C-w>+
nnoremap <M--> <C-w>-
nnoremap <M-<> <C-w><
nnoremap <M->> <C-w>>

" Clear search highlighting
nnoremap <C-z> :nohlsearch<CR>

" Terminal mode exit shortcut
:tnoremap <Esc> <C-\><C-n>

" Nerdtree git plugin symbols
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "ᵐ",
    \ "Staged"    : "ˢ",
    \ "Untracked" : "ᵘ",
    \ "Renamed"   : "ʳ",
    \ "Unmerged"  : "ᶴ",
    \ "Deleted"   : "ˣ",
    \ "Dirty"     : "˜",
    \ "Clean"     : "ᵅ",
    \ "Unknown"   : "?"
    \ }

function! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun

command! TrimWhitespace call TrimWhitespace() " Trim whitespace with command
autocmd BufWritePre * :call TrimWhitespace()  " Trim whitespace on every save

" Non-mapped function for tab toggles
function! TabToggle()
  if &expandtab
    set noexpandtab
  else
    set expandtab
  endif
endfunc

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"    Nerdtree
map <C-F> :NERDTreeToggle<CR>
map <C-S> :NERDTreeFind<CR>

" Other options
let mapleader=','
set backspace=2
colorscheme dracula
" colorscheme torte
syntax on
set shell=/bin/bash
set laststatus=2
set noshowmode

" Draw a line at 120 columns
" set colorcolumn=120
" highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Fixes broken cursor on Linux
set guicursor=

" NerdTree config
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1

                            " General editor options
set hidden                  " Hide files when leaving them.
set number                  " Show line numbers.
set numberwidth=1           " Minimum line number column width.
set cmdheight=2             " Number of screen lines to use for the commandline.
set textwidth=120           " Lines length limit (0 if no limit).
set formatoptions=jtcrq     " Sensible default line auto cutting and formatting.
set linebreak               " Don't cut lines in the middle of a word .
set showmatch               " Shows matching parenthesis.
set matchtime=2             " Time during which the matching parenthesis is shown.
set background=dark         " Color adapted to dark background.
set listchars=tab:▸\ ,eol:¬ " Invisible characters representation when :set list.
set clipboard=unnamedplus   " Copy/Paste to/from clipboard
set cursorline              " Highlight line cursor is currently on
set completeopt+=noinsert   " Select the first item of popup menu automatically without inserting it

" Search
set incsearch  " Incremental search.
set ignorecase " Case insensitive.
set smartcase  " Case insensitive if no uppercase letter in pattern, case sensitive otherwise.
set nowrapscan " Don't go back to first match after the last match is found.

" Fold
" set foldmethod=indent
" set foldlevelstart=1

" Indentation
"set autoindent
"set smartindent

" Tabs
set expandtab     " Tab transformed in spaces
set tabstop=2     " Sets tab character to correspond to x columns.
                  " x spaces are automatically converted to <tab>.
                  " If expandtab option is on each <tab> character is converted to x spaces.
set softtabstop=2 " column offset when PRESSING the tab key or the backspace key.
set shiftwidth=2  " column offset when using keys '>' and '<' in normal mode.

" Tabs
" Displays the list of multiple match for a tag by default.
" <C-]> is mapped to :tag <current_word> (jump to the first match) by default.
" g<C-]> is mapped to :tjump <current_word> (displays the list if multiple matches exist)
" nnoremap <C-]> g<C-]>

function! Refresh_tags(...)
  if !executable('ctags')
    echohl ErrorMsg
    echom 'Refresh_tags : `ctags` executable not found, cannot refresh tags.'
    echohl None
    return
  endif
  if a:0 > 0
    let dirPath = fnamemodify(a:1, ":p")
    call jobstart(["ctags", "-f", dirPath . "tags", "-R", dirPath])
  else
    call jobstart(["ctags", "-R", "."])
  endif
endfunction

" Toggle display of tabs and EOF
nnoremap <leader>l :set list!<CR>

" Auto-commands
" Vimscript
augroup vimscript_augroup
  autocmd!
  autocmd FileType vim nnoremap <buffer> <M-z> :execute "help" expand("<cword>")<CR>
augroup END

" Scala
" augroup scala_augroup
"  autocmd!
"  autocmd BufWritePost *.scala :call Refresh_tags()
"  autocmd BufWritePost *.scala Neomake
" augroup END

" Fuzzy finder shortcut
nnoremap <C-p> :FZF<CR>

" let g:LanguageClient_loggingLevel = 'DEBUG'

" LSP Plugin for Haskell (hie)
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
   \ 'haskell': ['hie-wrapper', '--lsp', '-d', '-l', '~/hie.log'],
   \ }

"   \ 'scala': ['~/development/metals/bin/metals-vim'],
"    \ 'scala': ['~/scalameta_lsp'],
"    \ 'scala': ['/workspace/oss/gimmerrors/.stack-work/install/x86_64-linux/lts-11.22/8.2.2/bin/gimmerrors'],
"    \ 'scala': ['~/coursier launch -r bintray:scalameta/maven org.scalameta:metals_2.12:0.1.0-M1+271-f80d7904 -M scala.meta.metals.Main'],

" Generate scalameta_lsp executable
" ./coursier bootstrap org.scalameta:metals_2.12:0.1.0-M1+271-f80d7904 -r bintray:scalameta/maven -r bintray:dhpcs/maven -M scala.meta.metals.Main -o scalameta_lsp -f --standalone

" Sarsi (https://github.com/aloiscochard/sarsi)
" call rpcstart('sarsi-nvim')

" vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" vim-lsc
"let g:lsc_enable_autocomplete = v:false
let g:lsc_server_commands = {
  \ 'scala': {
  \    'command': '~/development/metals/bin/metals-vim',
  \    'log_level': 'Log'
  \  }
  \}

let g:lsc_auto_map = {
  \ 'GoToDefinition': 'gd',
  \ 'FindReferences': 'gT',
  \ 'FindCodeActions': 'rui',
  \ 'ShowHover': 'K',
  \ 'Completion': 'completefunc',
\}

nnoremap <silent> <M-X> :LSClientAllDiagnostics<CR>
nnoremap <silent> <M-Z> :ccl<CR>
nnoremap <silent> <M-B> :call lsc#server#call(&filetype, 'workspace/executeCommand', { 'command': 'build-import' }, function('abs'))<CR>

" Close preview window on autocompletion (metals / vim-lsc)
autocmd CompleteDone * silent! pclose

"\ 'AllDiagnostics': 'gR' does not work
"\ 'Rename': 'gR',

" Shortcuts for LSP using Haskell
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <C-g> :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> F :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> B :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <C-a> :call LanguageClient_textDocument_codeAction()<CR>
nnoremap <silent> Z :call LanguageClient_textDocument_documentSymbol()<CR>

" Haskell plugins
nnoremap <silent> ;h :execute "Unite -start-insert haskellimport"<CR>
nnoremap <silent> <C-h> :execute "Unite hoogle"<CR>

" Diagnostics highlighting
hi link ALEError Error
hi Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=Gold
hi link ALEWarning Warning
hi link ALEInfo SpellCap

" Disable touchpad on startup / Enable it back on exit (at the OS level)
" autocmd VimEnter * !touchpad-on-off
" autocmd VimLeave * !touchpad-on-off

" Disable arrow keys and page up / down
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
vnoremap <Up> <nop>
vnoremap <Down> <nop>
vnoremap <Left> <nop>
vnoremap <Right> <nop>
noremap <PageUp> <nop>
inoremap <PageUp> <nop>
vnoremap <PageUp> <nop>
noremap <PageDown> <nop>
inoremap <PageDown> <nop>
vnoremap <PageDown> <nop>

" Disable mouse / touchpad (only in vim)
set mouse=
noremap <ScrollWheelUp> <nop>
noremap <S-ScrollWheelUp> <nop>
noremap <C-ScrollWheelUp> <nop>
noremap <ScrollWheelDown> <nop>
noremap <S-ScrollWheelDown> <nop>
noremap <C-ScrollWheelDown> <nop>
noremap <ScrollWheelLeft> <nop>
noremap <S-ScrollWheelLeft> <nop>
noremap <C-ScrollWheelLeft> <nop>
noremap <ScrollWheelRight> <nop>
noremap <S-ScrollWheelRight> <nop>
noremap <C-ScrollWheelRight> <nop>
