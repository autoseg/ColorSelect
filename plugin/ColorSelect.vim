""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin to select color and insert on document
" Author: Kássio Borges de Melo
"         <kassioborgesm@gmail.com>
" Dependencies:
"         * VIM 7.x
"         * Ruby
"         * ruby-gtk
"           ** to install this see this document:
"                 http://dannnylo.wordpress.com/2010/07/08/instalando-gtk-no-rvm/
"
""""""""""""""""""""""""""""""""""""""""""""""""
if !exists("g:FormatResultColorSelect")
  let g:FormatResultColorSelect='rgba'
endif
if !exists("g:CaseResultColorSelect")
  let g:CaseResultColorSelect='upcase'
endif
let s:install_dir = expand('<sfile>:p:h')
function! ColorSelectFunc()
  let result = system('ruby '.s:install_dir.'/ColorSelect.rb '.g:FormatResultColorSelect.' '.g:CaseResultColorSelect)
  let line = getline(".")
  let ant = getpos(".")[2]-1
  let pos = ant+1
  call setline(".", line[0 : ant].result.line[pos : col("$")-1])
endfunction

command! ColorSelect call ColorSelectFunc()
