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
if !exists("g:CaseResultColorSelect")
  let g:CaseResultColorSelect=''
endif
let s:install_dir = expand('<sfile>:p:h')
function! ColorSelectFunc()
  let result = system('ruby '.s:install_dir.'/ColorSelect.rb '.g:CaseResultColorSelect)
  let line = getline(".")
  let ant = getpos(".")[2]
  let pos = ant+1
  call setline(".", line[0 : getpos(".")[2]].result.line[getpos(".")[2]+1 : col("$")-1])
endfunction

command! ColorSelect call ColorSelectFunc()
