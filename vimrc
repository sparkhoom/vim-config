" Nathan L Smith's .vimrc
" http://github.com/smith/vim-config/

syntax on
set nocompatible
set number

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'airblade/vim-gitgutter'
Bundle 'digitaltoad/vim-jade'
Bundle 'gmarik/vundle'
Bundle 'guns/vim-clojure-static'
Bundle 'int3/vim-extradite'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'plasticboy/vim-markdown'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-tbone'
Bundle 'vim-ruby/vim-ruby'
Bundle 'Shutnik/jshint2.vim'
Bundle 'msanders/snipmate.vim'

Bundle 'csv.vim'
Bundle 'LargeFile'
Bundle 'TaskList.vim'
Bundle 'TwitVim'

filetype plugin indent on

" open a NERDTree automatically when vim starts up
autocmd vimenter * NERDTree
" General options
set autoread
set hidden
set incsearch
set ignorecase
set nobackup
set noswapfile
set smartcase
set spell
set spelllang=en_us
set showcmd
set switchbuf=useopen
set wildmenu
set wildmode=list:longest
set backspace=indent,eol,start
set history=1000
set pastetoggle=<F2>
set shortmess=at
set tags=./tags;/
set t_Co=256

" Status line
set laststatus=2 " Always show
" filename [modified (+ or -)] [fugitive info] [filetype]              row,col %
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P

" Tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2


" Use :w!! to save with sudo if you're editing a readonly file
cmap w!! w !sudo tee % >/dev/null

" Key Mappings
let mapleader=","
let g:mapleader=","

" <CTRL-P> for ctrlp.vim
let g:ctrlp_map = '<C-P>'

" Resize window to 80 width with ,8
map <leader>8 :vertical resize 80<CR>

" ,d for dispatch
map <leader>d :Dispatch<CR>

"remap shift tab to be omni-complete
inoremap <S-TAB> <C-X><C-O>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
" (stolen from Janus)
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" GUI options
if has("gui_running")
  " No menus and no toolbar
  set guioptions-=m
  set guioptions-=T

  " Left handed scrollbar
  set guioptions-=r
  set guioptions+=l

  set co=80
  set lines=45
endif

" Appearance
set ruler
set title
set wrap
if exists("+colorcolumn")
  set colorcolumn=81
endif
set cursorline
set scrolloff=3
colorscheme desert256

" Fix folded highlight in terminal
highlight Folded ctermfg=Yellow ctermbg=NONE
highlight FoldColumn ctermfg=Yellow ctermbg=NONE

" Highlight trailing whitespace
highlight ExtraWhitespace guibg=DarkCyan ctermbg=Blue
au ColorScheme * highlight ExtraWhitespace guibg=DarkCyan ctermbg=Blue
au BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
au BufWrite * match ExtraWhitespace /\s\+$\| \+\ze\t/

" Spelling highlights
highlight clear SpellBad
highlight SpellBad cterm=underline ctermfg=red

" Use ag for :Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

function! Indent4Spaces()
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
endfunction

" CSS-type things
au BufRead,BufNewFile,BufWrite {*.less} set ft=css

" Git shortcuts
function! s:GitCheckout(...)
  :silent execute 'Git checkout ' . a:1 . ' > /dev/null 2>&1' | redraw!
endfunction
command! -nargs=1 Gc call s:GitCheckout(<f-args>)

" Markdown
au BufRead,BufNewFile,BufWrite {*.markdown,*.md,*.mdk} set ft=markdown
au BufRead,BufNewFile,BufWrite {*.textile} set ft=textile

" Property lists
au BufRead,BufNewFile,BufWrite {*.plist} set ft=xml

" Syntastic mods
let g:syntastic_coffee_coffeelint_args = "--csv --file ~/.coffeelintrc"

" Use ruby syntax for additional ruby types
au BufRead,BufNewFile,BufWrite {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" JavaScript
au BufRead,BufNewFile,BufWrite {*.js.asp,*.json} set ft=javascript

" Indent-based folding
au BufRead,BufNewFile,BufWrite {*.json,,*.py,*.coffee,*.yaml,*.yml} set foldmethod=indent

" FIXME: This fails when you have Prototype.js style string inteporation like
"        #{prop} in a string
function! JavaScriptFold()
  setl foldmethod=syntax
  setl foldlevelstart=99
  syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

  function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
  endfunction
  setl foldtext=FoldText()
endfunction

" Lisp
au BufRead,BufNewFile,BufWrite {*.scm,*.scheme} set ft=lisp
au BufRead,BufNewFile,BufWrite {*.cljs} set ft=clojure
au BufRead,BufNewFile,BufWrite {*.clj,*.cljs} set nospell
let g:vimclojure#HighlightBuiltins=1      " Highlight Clojure's builtins
let g:vimclojure#ParenRainbow=1           " Rainbow parentheses'!

" FIXME: When js in rails projects is being edited, it uses 2 spaces. Figure
"        out how to not have rails.vim override this
au FileType javascript call Indent4Spaces()
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl foldlevel=99

" PHP
let php_folding=1
au FileType php call Indent4Spaces()
au FileType php setl foldlevel=99

" Python
au FileType python call Indent4Spaces()

" MacVim
if has("gui_macvim")
  set transp=1
  set anti enc=utf-8 gfn=Source_Code_Pro:h16,Menlo:h14,Monaco:h14
  set fuoptions=maxvert,maxhorz

  " Copy/paste on mac
  " (http://www.drbunsen.org/text-triumvirate.html#vim)
  " Yank text to the OS X clipboard
  noremap <leader>y "*y
  noremap <leader>yy "*Y
  " Preserve indentation while pasting text from the OS X clipboard
  noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>
endif

" Windows
if has("win32")
    " Use CUA keystrokes for clipboard: CTRL-X, CTRL-C, CTRL-V and CTRL-z
    source $VIMRUNTIME/mswin.vim
    set guifont=Consolas:h13:cANSI,Anonymous\ Pro:h13:cANSI
endif
