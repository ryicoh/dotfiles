if has('nvim')
  set runtimepath+=$HOME/.vim
endif

" deno系プラグインを使うためのやつ
call plugin#use('vim-denops/denops.vim')

" LSP
call plugin#use('prabirshrestha/vim-lsp')

" LSPの設定を言語ごとに自動で設定してくれるやつ
call plugin#use('mattn/vim-lsp-settings')

  " READMEのコピペ
  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    " 定義ジャンプ
    nmap <buffer> gd <plug>(lsp-definition)
    " 変数名変更
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    " 前のエラーに飛ぶ
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    " 次のエラーに飛ぶ
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    " アクションを開く
    nmap <buffer> ga <plug>(lsp-code-action)
    " 情報をみる
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 200
    " 保存した時、フォーマット
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
  endfunction

  augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

  " deno を使う場合は必要
  let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'deno']
  " let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_diagnostics_float_cursor = 1
  " ログ
  " let g:lsp_log_verbose = 1
  " let g:lsp_log_file = expand('/tmp/vim-lsp.log')

" ファイル検索, 曖昧検索してくれるやつ
call plugin#use('junegunn/fzf', {'build': { -> fzf#install() }})

" fzfのプレビュー見せてくれるやつ
call plugin#use('yuki-yano/fzf-preview.vim', {"branch": "release/rpc"})
  nmap <space>h <Cmd>FzfPreviewMruFilesRpc<CR>
  nmap <space>f <Cmd>FzfPreviewProjectFilesRpc<CR>
  nmap <space>g <Cmd>FzfPreviewGitActionsRpc<CR>
  nmap <Space>q <Cmd>FzfPreviewQuickFixRpc<CR>
  nmap <Space>d <Cmd>FzfPreviewVimLspDiagnosticsRpc<CR>
  nmap <Space>c <Cmd>FzfPreviewCommandPaletteRpc<CR>
  let g:fzf_preview_history_dir = '~/.config/nvim/.fzf_preview_history'

" grepだけこっち使う
call plugin#use('junegunn/fzf.vim')
  let $FZF_DEFAULT_OPTS = "--layout=reverse --info=inline --bind ctrl-b:page-up,ctrl-f:page-down,ctrl-u:up+up+up,ctrl-d:down+down+down"
  let g:fzf_history_dir = '~/.config/nvim/.fzf_history'
  let g:fzf_custom_options = ['--preview', 'bat --style=numbers --color=always --line-range :500'.' {}']
  command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden -g "!{node_modules,.git}" --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'window': {'width': 0.9,'height': 0.9}}), <bang>0)
  nmap <Space>r <Cmd>Rg<CR>

" Git
call plugin#use('lambdalisue/gina.vim')

" ステータスバー
call plugin#use('vim-airline/vim-airline')

" スニペット系
" スニペットのエンジン(Python依存
call plugin#use('SirVer/ultisnips')

" スニペットがいっぱい入ってるやつ
call plugin#use('honza/vim-snippets')
  " タブとShiftタブでジャンプ
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" 補完系
" 補完するエンジン
call plugin#use('prabirshrestha/asyncomplete.vim')

" LSPの補完を流してくれる
call plugin#use('prabirshrestha/asyncomplete-lsp.vim')

" スニペットの補完を流してくれる
call plugin#use('prabirshrestha/asyncomplete-ultisnips.vim')
  " ↓ タブ打ちたい時のために切っておく
  "inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  "inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>" 

" テスト
call plugin#use('vim-test/vim-test')
  let g:VimuxOrientation = "h"
  let g:VimuxHeight = "40"

" テストをtmuxで開いてくれる
call plugin#use('preservim/vimux')
  nmap <silent> t<C-n> :TestNearest<CR>
  nmap <silent> t<C-f> :TestFile<CR>
  nmap <silent> t<C-s> :TestSuite<CR>
  nmap <silent> t<C-l> :TestLast<CR>
  let test#strategy = "vimux"

" Go用のプラグイン
call plugin#use('fatih/vim-go', {'build': ':GoUpdateBinaries'})

" vimdoc翻訳用
call plugin#use('vim-jp/autofmt')

" カッコをうまいことしてくれる
call plugin#use('machakann/vim-sandwich')

" 色
call plugin#use("NLKNguyen/papercolor-theme")
  syntax on
  " デフォルトの256色から、もっとカラフルにするやつ
  if has('nvim')
    set termguicolors
  endif
  set t_Co=256
  set background=dark
  colorscheme PaperColor

" 文字コード
lang en_US.UTF-8
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis
set fileencoding=utf-8 fileformat=unix
set encoding=utf-8

" タブ使わずに空白使う系
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

" vimのヤンクをクリップボードと同期する
set clipboard=unnamedplus

" コマンドラインの補完メニュー
set wildmenu
" 最長一致のところまで補完して、タブを押すと選べる
set wildmode=longest:full,full

" 行番号
set number

" 行番号の左に１行開けてエラーのアイコンとかをつけるためのやつ
set signcolumn=yes

" 畳むやつは使わない
set nofoldenable

" 検索のハイライトを消す
nmap <space>/ <Cmd>nohlsearch<CR>

" netrwのバナー消す
let g:netrw_banner = 0

" タイポ対策
iabbrev cosnt const
" :w がどうしても :W になっちゃうので。update は変更があれば書き込んでくれる
cabbrev W update

" tabを>-にする
set list
set listchars=tab:>-

" defaults.vim
set incsearch

" タイムアウト
set ttimeout
set ttimeoutlen=100

" vimでdeleteが効くように
set backspace=indent,eol,start

