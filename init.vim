set directory=~/.vim/backup
set backupdir=~/.vim/backup " keep swap files here
filetype off                " required

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'                                         " git plugin
Plug 'vim-airline/vim-airline'                                    " bottom status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy finder conf
Plug 'junegunn/fzf.vim'                                           " fuzzy finder
Plug 'scrooloose/nerdtree'                                        " folders tree
Plug 'dracula/vim'                                                " dark theme
Plug 'derekwyatt/vim-scala'                                       " scala plugin
Plug 'kien/rainbow_parentheses.vim'                               " for nested parentheses
Plug 'tpope/vim-surround'                                         " quickly edit surroundings (brackets, html tags, etc)
Plug 'junegunn/vim-easy-align'                                    " alignment plugin
Plug 'neomake/neomake'                                            " run programs asynchronously and highlight errors
Plug 'ryanoasis/vim-devicons'                                     " add icons to NerdTree and other plugins
Plug 'Valloric/MatchTagAlways'                                    " highlights html enclosing tags
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }                                                           " LSP plugin for Haskell Ide Plugin (hie)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }     " autocompletion plugin

" Plug 'easymotion/vim-easymotion'
" Plug 'tpope/vim-repeat'

" Plug 'eed3si9n/LanguageClient-neovim'                           " when using Scala with LSP
" Plug 'Xuyuanp/nerdtree-git-plugin'                              " Shows files git status on the NerdTree
" Plug 'neovimhaskell/haskell-vim'
" Plug 'eagletmt/neco-ghc'

call plug#end()

" End of plugins here
" ===================

" Use deoplete
let g:python3_host_prog = '/usr/bin/python3'
let g:deoplete#enable_at_startup = 1

" Neomake on save
" autocmd! BufWritePost * Neomake

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

" Other options
let mapleader=','
set backspace=2
colorscheme dracula
syntax on
set shell=/bin/bash
set laststatus=2
set noshowmode

" Draw a line at 120 columns
set colorcolumn=120
highlight ColorColumn ctermbg=235 guibg=#2c2d27

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

let g:airline_theme='solarized'
let g:airline_powerline_fonts=1

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
augroup scala_augroup
  autocmd!
  autocmd BufWritePost *.scala :call Refresh_tags()
  autocmd BufWritePost *.scala Neomake
augroup END

" Fuzzy finder shortcut
nnoremap <C-p> :FZF<CR>

" Navigate to definition shortcut
nnoremap <C-g> <C-]>

" sbt-server
" set signcolumn=yes
"let g:LanguageClient_serverCommands = {
"    \ 'scala': ['node', expand('~/development/sbt-server-stdio.js')]
"    \ }

" LSP
let g:LanguageClient_autoStart = 1

" Haskell IDE Plugin
let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie', '--lsp', '-d', '-l', '~/hie.log'],
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
