syntax on

set fileencoding=utf-8 fileformat=unix

setlocal conceallevel=0
highlight Ignore ctermfg=red

" 整形用の設定例
set runtimepath+=~/.vim/plugins/autofmt/
set formatexpr=autofmt#japanese#formatexpr()  " kaoriya 版では設定済み
let autofmt_allow_over_tw = 1  " 全角文字がぶら下がりで 1 桁はみ出すのを許可
set formatoptions+=mB          " または mM
set smartindent

syntax match Error /\%>79v.*/
set colorcolumn=+1

set path=**
