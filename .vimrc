"TODO change this to dynamic home
cd C:\Users\CSCPU36\Downloads
set encoding=utf-8

if has("win32")
  set nocompatible

  set nobackup
  set nowritebackup

  " To make sure text displays correctly
  let g:airline_powerline_fonts = 1
  set guifont=Courier_New:h11:cANSI

  " Tell to use windows configuration
  source $VIMRUNTIME/mswin.vim
  behave mswin

  set diffexpr=MyDiff()
  function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        let cmd = '""' . $VIMRUNTIME . '\diff"'
        let eq = '"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
  endfunction
endif


" Disable graphical tabs
set guioptions=gm

" Maintainer:	Daniel Prado <danazkari@gmail.com>


" ========================================
" General Set up
" ========================================

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if &shell =~# 'fish$'
    set shell=sh
endif

set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78


  " Omni Completion
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  " always set autoindenting on
  set autoindent

endif " has("autocmd")

" If a search is done something containing uppercase characters, it will do a case sensitive search;
" if a search is done for something purely lowercase, it will do a case insensitive search.
" Behaviour can be overriden with the use of \c and \C
set smartcase

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'

Plug 'nvie/vim-flake8'

Plug 'Chiel92/vim-autoformat'

Plug 'gf3/vim-css-color'

Plug 'kchmck/vim-coffee-script'

Plug 'mattn/gist-vim'

Plug 'tpope/vim-haml'

Plug 'nono/vim-handlebars'

Plug 'vim-scripts/indentpython.vim'

Plug 'vim-scripts/jade.vim'

Plug 'pangloss/vim-javascript'

Plug 'davidhalter/jedi-vim'

Plug 'plasticboy/vim-markdown'

Plug 'tpope/vim-rails'

Plug 'tpope/vim-repeat'

Plug 'vim-ruby/vim-ruby'

Plug 'tmhedberg/SimpylFold'

Plug 'wavded/vim-stylus'

Plug 'tpope/vim-surround'

Plug 'vim-scripts/lint.vim'

Plug 'scrooloose/nerdtree'

Plug 'honza/vim-snippets' " Default snippets package

Plug 'scrooloose/syntastic'

Plug 'airblade/vim-gitgutter'

Plug 'SirVer/ultisnips'

Plug 'matthewsimo/angular-vim-ultisnips'

Plug 'marijnh/tern_for_vim'

Plug 'mxw/vim-jsx'

Plug 'editorconfig/editorconfig-vim'

Plug 'bling/vim-airline'

Plug 'lambdatoast/elm.vim'

Plug 'isRuslan/vim-es6'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'elzr/vim-json'

Plug 'mattn/emmet-vim'


" Themes:
Plug 'sickill/vim-monokai'

Plug 'jnurmine/Zenburn'

Plug 'altercation/vim-colors-solarized'


call plug#end()


" ========================================
" Personal Settings
" ========================================

" Use C-r to replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" When folding docstrings will still be visible
let g:SimpylFold_docstring_preview=1

" Pretty code
let python_highlight_all=1
syntax on

" if has('gui_running')
"   set background=dark
"   colorscheme solarized
" else
"   colorscheme zenburn
" endif
set background=light
colorscheme solarized


" Insert longest common text of all matches and show menu even
" if there is only one option
:set completeopt=longest,menuone

" Use enter to select entry from autocomplete menu
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" When C-n pressed simulate a down press: keeps a menu item always highlighted
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" simulates <C-X><C-O> to bring up the omni completion menu, then it simulates <C-N><C-P> to remove the longest common text, and finally it simulates <Down> again to keep a match highlighted.
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


"~/.vim/backup Set where backups go
set backupdir=C:\Program\ Files\ (x86)\Vim\vim74\backup
set noswapfile


" Personal flavor
" set relativenumber
set number
set hidden

" Indents
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set tabstop=2
set expandtab
"set softtabstop=2

set encoding=utf-8
set t_Co=256

" Folding
set foldmethod=indent
set foldlevel=99
set foldnestmax=8
set nofoldenable
set cmdheight=2


filetype plugin on
filetype indent on


set nowrap
set magic
set showmatch
set noerrorbells
set incsearch
set hlsearch


" Scrolling
set scrolloff=10
set sidescrolloff=15
set sidescroll=1


" syntax highlighting & solarized config
syntax on
" let &t_Co=256
" let g:solarized_degrade=0
" let g:solarized_italic=1
" let g:solarized_bold=1
" let g:solarized_underline=1
" colorscheme monokai
" set background=dark



" Set sign column clear
highlight clear SignColumn


" Default Cursor line in current window only.
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Tern for vim
let g:tern_map_keys=1

" Nerd Tree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore .pyc files in NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap ,n :NERDTreeFind<CR>

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }


" Command mode completion

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

set runtimepath^=~/.vim/bundle/ctrlp.vim



" Set GitGutter on!
let g:gitgutter_enabled = 1


" Define Map Leader
:let mapleader = "-"


" Remember info about open buggers on close
set viminfo^=%


" Disable lint
:let disable_lint = 1


set laststatus=2


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline_symbols.readonly = ''
let g:airline_symbols.crypt = ''
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.branch = '⎇'

let g:airline_detect_iminsert=1
let g:airline#extensions#syntastic#enabled = 1


let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.ctrlp']
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip

" Syntastic config

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_shell=$PATH
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

" Match settings
set matchpairs+=<:>     " specially for html

let g:UltiSnipsSnippetsDir="~/.vim/bundle/ultisnips/Ultisnips"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "angular-snippets"]
let g:UltiSnipsExpandTrigger="<f5>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"


" ========================================
" Utility Functions & Custom Commands
" ========================================


" Highlight trailing white space for find/replace
func! DeleteTrailingWS()
  %s/\s\+$//e
endfunc


" Reset current search
command! C let @/=""


" auto format JSON File
command! F :%!python -m json.tool


" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif


" Visual * - Search for selected text * = next # = prev
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


" python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF


" ========================================
" Custom Mappings
" ========================================

" Space in normal mode will fold code
nnoremap <space> za


nmap <silent> <c-n> :NERDTreeToggle<CR>


" Quick Edit for .vimrc
:nnoremap <leader>ev :split $MYVIMRC<cr>


" Source Vim
:nnoremap <leader>sv :source $MYVIMRC<cr>


" Edit Snippets for this file type
:nnoremap <leader>es :split :UltiSnipsEdit<cr>

" Remap keys used for tabs
:nnoremap <leader>J J

" F3 for autoformat
noremap <F3> :Autoformat<CR>

" Mapping to move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Map some keys for easier tab usage
map <S-h> :tabfirst<CR>
map <S-j> :tabprevious<CR>
map <S-k> :tabnext<CR>
map <S-l> :tablast<CR>


" Map for nerd tree - to control n in normal mode
nmap ,w :w<CR>
nmap ,x :x<CR>

" Map for Search/Replace Trailing White space
:nnoremap <leader>ws :call DeleteTrailingWS()<CR>

" Toggle GitGutter
:nnoremap <leader><Tab> :ToggleGitGutter<CR>

" Toggle GitGutter line highlighting
:nnoremap <leader>` :ToggleGitGutterLineHighlights<CR>

" GitGutter Next hunk ~ hubba hubba
:nnoremap <leader>n :GitGutterNextHunk<CR>

" GitGutter prev hunk
:nnoremap <leader>N :GitGutterPrevHunk<CR>


" Toggle Paste Mode & auto unset when leaving insert mode
:nnoremap <leader>v :set paste!<CR>i
au InsertLeave * set nopaste

" Manually bind ListSnippets function, since setting option never worked...
:nnoremap <leader><Space> :call UltiSnips_ListSnippets()<CR>

" Split Window Creation Helpers
:nnoremap <leader>9 :split<CR>
:nnoremap <leader>( :split
:nnoremap <leader>0 :vsplit<CR>
:nnoremap <leader>) :vsplit

" Split Windows Sizing Helpers ((in/de)crease by four)
:nnoremap <leader>, <C-w>+
:nnoremap <leader>. <C-w>-
:nnoremap <leader>< <C-w><
:nnoremap <leader>> <C-w>>

" Quote-Fu - handle quoting words quick and easy
"   Quote Add Single
:nnoremap <leader>qas ciw'<C-r>"'
"   Quote Add Double
:nnoremap <leader>qad ciw"<C-r>""
"   Quote Remove Single
:nnoremap <leader>qrs di'hPl2x
"   Quote Remove Double
:nnoremap <leader>qrd di"hPl2x
"   Quote Change to Single
:nnoremap <leader>qcs di"hPl2xhciw'<C-r>"'<esc>
"   Quote Change to Double
:nnoremap <leader>qcd di'hPl2xhciw"<C-r>""<esc>


"	Find, right before
":nnoremap <leader>f fh


" Copy to Clipboard
vnoremap <leader>c :w !xsel --clipboard --input<CR><CR>

" Pretty print JSON
:nnoremap <leader>ppj :%!python -m json.tool<CR>


" ========================================
" Custom Abbreviations
" ========================================


" ========================================
" Special File Type Support
" ========================================

" EJS Templates as html
au BufNewFile,BufRead *.ejs set filetype=html

" Set jsx for .js files as well as .jsx
let g:jsx_ext_required = 0

" Autoindent settings in Python files
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" Mark extra white space
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Autoindent settings in js, *jsx, html and css files
au BufNewFile,BufRead *.js, *.html, *.css, *.jsx
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
