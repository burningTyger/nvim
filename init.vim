" key mappings
let mapleader = ","

call plug#begin('~/.vim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'airblade/vim-gitgutter'
" syntax files
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-haml'
Plug 'depuracao/vim-rdoc'
Plug 'cakebaker/scss-syntax.vim'
" toml files
Plug 'maralla/vim-toml-enhance'
Plug 'cespare/vim-toml'
" handlebars
Plug 'joukevandermaas/vim-ember-hbs'
" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
"

" themes
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-repeat'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neopairs.vim'
" create new dirs
Plug 'pbrisbin/vim-mkdir'

" deoplete
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
Plug 'shougo/deoplete-rct'
Plug 'fishbullet/deoplete-ruby'

" airline
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1

" vim-slim
Plug 'slim-template/vim-slim'
syntax enable
filetype plugin indent on

" syntastic
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_auto_loc_list=2

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <c-p> :FZF<cr>
nnoremap <leader>p :History<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>a :Lines<CR>
nnoremap <leader>l :BLines<CR>
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
nnoremap <leader>f :F<CR>

" ctrlp
" Plug 'kien/ctrlp.vim'
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_custom_ignore = {
"       \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"       \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
"       \ }

Plug 'bronson/vim-trailing-whitespace'
nnoremap <leader>w :FixWhitespace<CR>


call plug#end()

" weiteres
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby
au FileType make setlocal noexpandtab
au FileType markdown setlocal wrap linebreak textwidth=72 nolist

au FileType python setlocal tabstop=4 shiftwidth=4

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g`\"" | endif

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q


" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Adjust viewports to the same size
map <Leader>= <C-w>=

""
"" Basic Setup
""

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
" off and the line continues beyond the left of the screen

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""
"cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

:set colorcolumn=80
:set hidden
"set statusline=%f\ %m\ %r

:runtime macros/matchit.vim

" remap pane moves
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" start scrolling before cursor reaches border
set scrolloff=6

" unmark hilighted search results
noremap <Leader>m :nohlsearch<CR>
map <Leader>p <C-^> " Go to previous file

imap uu _
imap hh =>
imap aa @
imap öö {
imap ää }
imap ßß [
imap üü ]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ai "Auto indent
set si "Smart indent

" map jj to Escape
imap jj <Esc> " Professor VIM says '87% of users prefer jj over esc', jj abrams disagrees
" Insert New Line *************************************************************
map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
map <Enter> o<ESC>


" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
colorscheme Tomorrow-Night-Eighties
set background=light
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE
highlight LineNr ctermfg=grey

" Always show statusline
set laststatus=2

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

if has("autocmd")
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby let g:rubycomplete_classes_in_global=1
endif

" folding via Spacae bar
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"fucking laptop keybooard §$%&
nnoremap <PageUp> h
nnoremap <PageDown> l

" moving lines around in all modes:
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
inoremap <leader>j <Esc>:m .+1<CR>==gi
inoremap <leader>k <Esc>:m .-2<CR>==gi
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv
