" File: vimrc
" Author: James Rutherford
" Created: 2003-04-01
" Last Updated: 2012-06-29
" Note: For most systems, you can ignore the gentoo-specific things at the end
" of this file; they won't do any harm.

" set some useful defaults
"colorscheme af         " nice color scheme
set tabstop=4           " set tabs to 4 spaces wide
set softtabstop=4
set shiftwidth=4        " # of spaces to use for each (auto) indent step
set expandtab           " expand tabs to spaces
set backspace=indent,eol,start " make backspace delete lots of things
"set autoindent          " use automatic indenting
set smartindent         " use smart indenting
"set foldenable          " enable code folding
"set foldmethod=syntax
set grepprg=grep\ -nH\ $    " required for latexsuite - sets :grep default
set nrformats=alpha,hex " allows C-A and C-X to (de/in)crement letters & hex
set nocompatible        " use Vim defaults (much better!)
set bs=2                " allow backspacing over everything in insert mode
"set backup              " keep a backup file. maybe set backupdir first...
set viminfo='20,\"500   " read/write a .viminfo file -- limit regs to 500 lines
set undolevels=1000     " nice large upper limit on undo
set history=50          " keep 50 lines of command history
set ruler               " show the cursor position all the time
set incsearch           " highlight searches while you type them
set mouse=a             " use the mouse for visual selects, scrolling, etc...
set fileformat=unix     " er... <LF> anyone?
set wildmenu            " enable more advanced tab completion -- nice
set title               " let xterm inherit the title according to vim
set autoread            " auto-load a file that has changed outside of vim
                        " (but that hasn't been changed within vim)
set formatoptions=tcqron        " this one does a few things:
        " tc - auto wrap using textwidth (set to 80 with ,t)
        " q  - allow formatting of comments with 'gq'
        " ro - automatically insert the comment leader on the next line
        " a  - automatically format paragraphs every time text is
        "      inserted or deleted
        " n  - when formatting, recognise numbered lists & auto-insert next
set fileencodings+=default  " a sane fallback for encoding detection
let html_use_css=1      " make :TOhtml use CSS instead of <font> lame-ness
let use_xhtml=1         " make :TOhtml use XHTML instead of plain HTML
let loaded_matchparen=1 " prevent parenthesis-matching (vim >= 7)
set ttyfast
set ttyscroll=0
set splitright          " opens vertical splits to the right
set laststatus=2        " always show the full status line
"let loaded_vimspell = 1 " disables automatic spell-checking

set scrolloff=4         " start scrolling when we're 4 lines from the edge
set sidescrolloff=16
set sidescroll=1

" when doing tab completion, give the following files lower priority. also see
" 'wildignore' to completely ignore files, and 'wildmenu' to enable enhanced
" tab completion.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out

" switch on syntax/search highlighting when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" use language-sensitive indenting & plugins if the ftplugin directory exists
if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype plugin on
  filetype indent on
endif

" when displaying line numbers, don't use an annoyingly wide number column. the 
" value given is a minimum width to use for the number column.
if v:version >= 700
  set numberwidth=3
endif

" If we have a BOM, always honour that rather than trying to guess.
if &fileencodings !~? "ucs-bom"
  set fileencodings^=ucs-bom
endif

" Always check for UTF-8 when trying to determine encodings.
if &fileencodings !~? "utf-8"
  set fileencodings+=utf-8
endif

if &term ==? "xterm"
  " Previously we would unset t_RV to prevent gnome-terminal from beeping as
  " vim started.  These days it appears that gnome-terminal has been repaired,
  " so re-enable this, and don't restrict t_Co=8.  (21 Jun 2004 agriffis)
  "set t_RV=            " don't check terminal version
  "set t_Co=8
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2   " only works for >=xfree86-3.3.3, should be okay
endif

if $TERM == "screen"
   set t_kb=
"   set term=xterm-color
"   fixdel
"   set bs=2
endif

if &term =~# '^\(screen\|xterm\)'
    set t_Co=256
endif


" :W to sudo-write
command! W w !sudo tee % > /dev/null

filetype on
filetype plugin on
filetype indent on

" highlight over 80 chars
"highlight OverLength ctermbg=black ctermfg=red guibg=#592929
"match OverLength /\%81v.\+/

" could be in here, but it's crowded already!
source ~/.vim/jimr/autocmd.vim
source ~/.vim/jimr/maps.vim
source ~/.vim/jimr/plugins.vim
source ~/.vim/jimr/pymaps.vim

" set up some nice colours with the solarized scheme
let g:solarized_style="dark"
let g:solarized_contrast="high"
let g:solarized_termcolors=256
let g:solarized_visibility="high"
set background=dark     " default to dark background
"colorscheme solarized

" Vundle for bundle management!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" base vundle, required
Bundle 'gmarik/vundle'

" github plugins
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'msanders/snipmate.vim'
Bundle 'nvie/vim-flake8'
Bundle 'juvenn/mustache.vim'
Bundle 'kien/ctrlp.vim'

" vim.org scripts
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'mako.vim'
Bundle 'indentpython.vim'
Bundle 'taglist.vim'
Bundle 'pep8'
Bundle 'PySmell'
Bundle 'pylint.vim'
Bundle 'pyflakes.vim'
Bundle 'tslime.vim'
Bundle 'python_match.vim'
Bundle 'vim-coffee-script'
Bundle 'csv.vim'
