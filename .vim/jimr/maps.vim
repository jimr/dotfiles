" File: maps.vim
" Author: James Rutherford
" Created: 2005-05-07
" Last Updated: 2013-03-05
" Description: A collection of keymappings to make common tasks accessible
" with fewer keystrokes.
" Usage: Usually lives in the plugin directory and is automatically sourced at
" runtime. Also, it can be sourced directly with :source jimsmappings.vim

" save/restore current session
"map <F3> :mksession!<CR>
"if filereadable("Session.vim")
"	map <S-F3> :so Session.vim<CR>:noh<CR>
"endif

" Tab navigation like firefox. FIXME: why don't the <C-*-tab> ones work?
":nmap <C-S-Tab> :tabprevious<cr> 
":nmap <C-Tab> :tabnext<cr> 
":map <C-S-Tab> :tabprevious<cr> 
":map <C-Tab> :tabnext<cr> 
":imap <C-S-Tab> <ESC>:tabprevious<cr>i 
":imap <C-Tab> <ESC>:tabnext<cr>i 
:imap <C-t> <ESC>:tabnew<CR>
:nmap <C-t> :tabnew<CR> 
:map <S-Tab> :tabnext<CR> 
:imap <S-Tab> <ESC>:tabnext<CR>i

" remove any special highlighting (such as highlighting anything over 80 chars)
map ,m :match none <CR>

" remove any regualr highlighting
map ,n :noh<CR>

" make!
map <F2> :!make<CR>

" let the cursor be positioned where there is no actual character (on/off)
map <Leader>v :set virtualedit=all<CR>
map <Leader><S-V> :set virtualedit=<CR>


" set textwidth to something sensible
map ,t :set textwidth=80 <CR>

" set an 80 character word wrap - this seems a little pointless...
map <C-Q><C-W> :set wrapmargin=80 <CR>


" set some keymappings for winexplorer (Ctrl-W Ctrl-T toggles it on/off)
map <C-W><C-F> :FirstExplorerWindoW<CR>
map <C-W><C-B> :BottomExplorerWindoW<CR>
map <C-W><C-T> :WMToggle<CR>

" source a vimrc
map ,s :source ~/.vimrc <CR><ESC>
map \s :source /etc/vim/vimrc <CR><ESC>

" buffer switching shortcuts (prev/next)
map <C-B><C-P> :bp <CR>
map <C-B><C-N> :bn <CR>
map <F9> :bp <CR>
map <F10> :bn <CR>


" look up the word under the cursor on dict.org/php.net/google.co.uk
" lowercase: use a new tab in opera, upper case: use links2
map <Leader>d :!dict <cWORD><CR>
map <Leader>G :!links2
	\ "http://www.google.co.uk/search?hl=en&q=".<cWORD>.""
	\ <CR>
map <Leader>g :!opera -newpage
	\ "http://www.google.co.uk/search?hl=en&q=".<cWORD>.""
	\ <CR>


" toggle paste mode (for pasting content from the clipboard)
"map <F11> :set invpaste<CR>
map <F12> :call InvertPasteNMouse()<CR>
fun! InvertPasteNMouse()
	if &mouse == ''
		set mouse=a | set nopaste
		echo "mouse mode on, paste mode off"
	else
		set mouse= | set paste
		echo "mouse mode off, paste mode on"
	endif
endfunction


" show buffers
map <C-B><C-L> :ls <CR>
map <F8> :ls <CR>


" show line numbers
map <C-N><C-N> :set invnumber <CR>


" show marks
map <C-M><C-L> :marks <CR>


" lhs comments
map ,# :s/^/#/<CR>:nohlsearch<CR>
map ,/ :s/^/\/\//<CR>:nohlsearch<CR>
map ,> :s/^/> /<CR>:nohlsearch<CR>
map ," :s/^/\"/<CR>:nohlsearch<CR>
map ,% :s/^/%/<CR>:nohlsearch<CR>
map ,! :s/^/!/<CR>:nohlsearch<CR>
map ,; :s/^/;/<CR>:nohlsearch<CR>
map ,- :s/^/--/<CR>:nohlsearch<CR>

" remove lhs comments
map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>


" wrapping comments
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohlsearch<CR>
map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:nohlsearch<CR>
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>

" remove wrapping comments
map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR>


" fast resizing of windows using +/-
if bufwinnr(1)
	map + <C-W>+
	map - <C-W>-
endif


" word count. also see g<C-G>
"map <C-C><C-C> :!wc -w % \| awk '{print "total words in %: " $1}'<CR>
map <C-C><C-C> :echo system("wc -w ".expand("%")." \|
	\ awk '{print \"total words in ".expand("%").": \" $1}'")<CR>


" Don't use Ex mode, use Q for formatting
map Q gq


fun! ShowFuncName() 
	let lnum = line(".") 
	let col = col(".") 
	echohl ModeMsg 
	echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW')) 
	echohl None 
	call search("\\%" . lnum . "l" . "\\%" . col . "c") 
endfun 
map f :call ShowFuncName() <CR>

" ctags whatnot
map <F6> :Tlist<CR>

" FuzzyFinder maps
map ,,f :FufFile<CR>
map ,,F :FufCoverageFile<CR>
map ,,q :FufQuickfix<CR>
map ,,c :FufChangeList<CR>
map ,,l :FufLine<CR>

" Wean off the arrows!
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" ; in normal mode to save
noremap ; :w<CR>

nnoremap - :Switch<CR>

map <Leader>gg :ToggleGitGutter<CR>
