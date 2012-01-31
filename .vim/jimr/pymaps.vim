" File: pymaps.vim
" Author: James Rutherford
" Created: 2006-03-12
" Last Updated: 2012-01-23
" Description: Mappings for autogeneration of python code in .py files.
" Usage: Usually lives in the plugin directory and is automatically sourced at
" runtime.
" Note: Requires my vimrc (specifically, the formatoptions=ron part).

autocmd BufNewFile,BufRead *.py ks|call PyMaps()|'s

fun! PyMaps()
	" insert dome useful debugging code
    map! =pdb import pdb; pdb.set_trace()
    map! =ipdb import ipdb; ipdb.set_trace()
    map! =lg import logging <CR>log = logging.getLogger(__name__) <CR>log.setLevel(logging.DEBUG)<CR>log.debug('%s' % (,))<ESC>2hi
    map! =dbg log.debug('%s' % (,))<ESC>2hi
    map! =shell from IPython import embed <CR>embed()
    map! =tb import sys, traceback<CR>traceback.print_exc(file=sys.stdout) <CR>
    map <F5> :call Send_to_Tmux("python ".expand("%:p")."\n") <CR>
endfun

