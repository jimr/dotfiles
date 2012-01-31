" File: autocmd.vim
" Author: James Rutherford
" Created: 2005-05-07
" Last Updated: 2012-01-31
" Description: A collections of automated actions that are triggered by some
" internal event.
" Usage: Usually lives in the plugin directory and is automatically sourced at
" runtime. Also, it can be sourced directly with :source jimsautocommands.vim

if has("autocmd")
	" auto add 'shebang' lines to the start of certain files
	augroup Shebang
	  au!
		autocmd BufNewFile *.py
			\ 0put =\"#!/usr/bin/env python
			\ \<nl># -*- coding: iso-8859-15 -*-\<nl>\"|$
		autocmd BufNewFile *.rb
			\ 0put =\"#!/usr/bin/env ruby
			\ \<nl># -*- coding: None -*-\<nl>\"|$
		autocmd BufNewFile *.sh
			\ 0put =\"#!/bin/bash\<nl>\"|$
		autocmd BufNewFile *.pl
			\ 0put =\"#!/usr/bin/perl\<nl>\"|$
		autocmd BufNewFile *.\(cc\|hh\)
			\ 0put =\"//
			\ \<nl>//  \".expand(\"<afile>:t\").\"  --
			\ \<nl>//\<nl>\"|2|start!
		
		" The following three are a little more complicated, so the
		" auto-inserted text comes from a skeleton file.
		autocmd BufNewFile *.java
			\ 0read ~/.vim/skeletons/java.skel
			\ |call PrepareJavaClass()|10|start
		fun! PrepareJavaClass()
			if line("$") > 20
			    let l = 20
			else
				let l = line("$")
			endif
			exe "1," . l . "g/Created:/s/Created:.*/Created: "
                \ .strftime("%Y-%m-%d")
"			exe ":g/<file>/s/<file>/".expand("%")."/"
			exe ":g/<file>/s/<file>/".expand("%:t:r").".java/"
			exe ":g/<class>/s/<class>/".expand("%:t:r")."/"
		endfun
		autocmd BufNewFile *.html
			\ 0read ~/.vim/skeletons/html.skel
			\ |8|start!
		autocmd BufNewFile *.tex
			\ 0read ~/.vim/skeletons/tex.skel
			\ |10|start!
	augroup END

	" auto update the last updated time at the start of the file on write
	augroup Update
		autocmd BufWritePre * normal m`<CR>
		" FIXME: Why doesn't this work?
"		autocmd BufWritePost * normal `m<CR>
		autocmd BufWritePost * normal $<CR>
"		autocmd BufWritePost * normal ``<CR>
		autocmd BufNewFile,BufWritePre,FileWritePre * ks|call LastMod()|'s
		fun! LastMod()
			if line("$") > 20
			    let l = 20
			else
				let l = line("$")
			endif
			" FIXME: Why doesn't this just work with [Uu] ?
			exe "1," . l . "s/Last updated:.*/Last updated: "
				\ . strftime("%Y-%m-%d") . "/e"
			exe "1," . l . "s/Last Updated:.*/Last Updated: "
				\ . strftime("%Y-%m-%d") . "/e"
		endfun
		autocmd BufWritePost,FileWritePost *.tex ks|call WordCount()|'s
		fun! WordCount()
			if line("$") > 20
			    let l = 20
			else
				let l = line("$")
			endif
			let s:words=system("echo -n \"`cat "
				\ .expand("%")."`\" | detex | wc -w")
			let s:words = substitute(s:words,'\([0-9]*\).*','\1',"")
			" FIXME: Why doesn't this just work with [Cc] ?
			exe "1," . l . "s/Word count:.*/Word count: "
				\ . s:words . "/e"
			exe "1," . l . "s/Word Count:.*/Word Count: "
				\ . s:words . "/e"
		endfun
	augroup END

	augroup Other
		" In text/tex files, limit the width of text to 80 characters, but be
		" careful that we don't override any other setting.
		autocmd BufNewFile,BufRead *.\(txt\|tex\)
			\ if &tw == 0 && ! exists("g:leave_my_textwidth_alone") |
			\     setlocal textwidth=80 |
			\ endif
		
		" set keyword program (K) to default help for php files
		autocmd BufNewFile,Bufread *.\(html\|php\) set keywordprg="help"

		" some things for jcommenter.vim
		autocmd FileType java let b:jcommenter_class_author='James Rutherford'
		autocmd FileType java let b:jcommenter_file_author='James Rutherford'
		autocmd FileType java source
			\ ~/.vim/macros/jcommenter.vim
		autocmd FileType java source
			\ ~/.vim/macros/jcommenterconfig.vim
		autocmd FileType java map <M-c> :call JCommentWriter()<CR>
		autocmd FileType java map ,j :call JCommentWriter()<CR>

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event
		" handler (happens when dropping a file on gvim).
		autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal g`\"" |
			\ endif

		" automatically (internally) cd to the directory of the current file
		autocmd BufEnter *
			\ if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

		" remove any trailing ^M's or whitespace (i think the 1st is redundant)
		" i think these are both made redundant by setting fileformat=unix...
"		autocmd BufRead * silent! %s/\r\+$/\n/
"		autocmd BufRead * silent! %s/[\r \t]\+$//

		" highlight anything over 80 characters
"		autocmd BufNewFile,BufRead * exec 'match Todo /\%>' . 80 . 'v.\+/'

		" auto-source vimrc files after writing
		autocmd BufWritePost *\(vimrc\|.vimrc\) :so %

		" make shell scripts executable after writing
"		autocmd BufWritePost *.sh :!chmod +x %

		" When editing a file, always jump to the last cursor position
		autocmd BufReadPost *
			\ if ! exists("g:leave_my_cursor_position_alone") |
			\     if line("'\"") > 0 && line ("'\"") <= line("$") |
			\         exe "normal g'\"" |
			\     endif |
			\ endif
	augroup END
endif " has("autocmd")

