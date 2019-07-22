set encoding=utf-8

set wrap linebreak nolist nojoinspaces
set nobackup noswapfile nowritebackup
set noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
set textwidth=80
set title number completeopt-=preview
set ignorecase smartcase
set showmode showcmd hidden wildmode=list:longest
set background=dark
set statusline=%!bufnr('%')

colorscheme pablo

syntax on
""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Functions
"
""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
function! DoRemoteUpdate(arg)
  UpdateRemotePlugins
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugins
"
""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.nvim/plugged')

" UI
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Code completion
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemoteUpdate')} 
Plug 'ervandew/supertab'

" Others
Plug 'Raimondi/delimitMate'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Languages
Plug 'exu/pgsql.vim', { 'for': 'sql' }
Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make' }
Plug 'vim-jp/vim-go-extra', { 'for': 'go' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'elzr/vim-json', { 'for': 'json' } 
Plug 'leafgarland/typescript-vim', { 'for': 'typescript'} | Plug 'Quramy/tsuquyomi'
Plug 'mxw/vim-jsx', { 'for': 'jsx'}
Plug 'ianks/vim-tsx', { 'for': 'tsx'}

call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugin settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""
let delimitMate_expand_cr = 1
let g:closetag_filenames = '*.html,*.xml'
let g:deoplete#enable_at_startup = 1
let g:flow#qfsize = 0
let g:jsx_ext_required = 0
let g:sql_type_default = 'pgsql'
let g:SuperTabDefaultCompletionType = '<c-n>'
let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_disabled = 1
let g:airline_theme='badcat'

"---------------------------------------------------
"
" Keys remap
"
"---------------------------------------------------
nnoremap ; :

" Disable arrow keys
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

" language server keys
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> gt :call LanguageClient#textDocument_formatting_sync()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Other settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""

" override file settings
autocmd FileType html,xml,ruby,sh,javascript,jsx,json,yaml,sql,vim,cmake,proto,typescript,ps1,gitconfig setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd BufNewFile,BufRead *.rules setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd BufNewFile,BufRead *.js,*.vue,*.bolt setlocal filetype=typescript
autocmd BufNewFile,BufRead *.go.tpl,*.qtpl,*.gunk setlocal syntax=go

" launch language servers
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }

" run gofmt and goimports on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

"let g:gofmt_command = "goimports"
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
