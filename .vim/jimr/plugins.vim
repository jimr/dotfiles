" File: plugins.vim
" Author: James Rutherford
" Created: 2012-01-31
" Last Updated: 2019-11-23
" Description: Collected plugin configuration.

"" TagList configuration
"let Tlist_Use_Right_Window = 1
"let Tlist_WinWidth = 40
"let Tlist_Show_One_File = 1
"let Tlist_Process_File_Always = 1
"let Tlist_Enable_Fold_Column = 0

" default is <c-n>, which is stupid
let g:sparkupNextMapping = '<c-x>'
let g:pep8_map = ",p"

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_pylint_quiet_messages = {
    \ "regex": [
        \ "no-member",
        \ "attribute-defined-outside-init",
        \ "super-on-old-class",
        \ "import-error"],
    \ "level": "warnings" }
