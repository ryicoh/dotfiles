let start_time = reltime()

call plug#begin('~/.config/nvim/plugged')
    " deno系プラグインを使うためのやつ
    Plug 'vim-denops/denops.vim'

    Plug 'yuki-yano/fuzzy-motion.vim'
    nnoremap <C-s> <Cmd>FuzzyMotion<CR>
    xnoremap <C-s> <Cmd>FuzzyMotion<CR>
    let g:fuzzy_motion_labels = [
      \ "\<C-a>", "\<C-s>", "\<C-d>", "\<C-f>", "\<C-g>", "\<C-h>", "\<C-j>",
      \ "\<C-k>", "\<C-l>", "\<C-q>", "\<C-w>", "\<C-e>", "\<C-r>", "\<C-t>",
      \ "\<C-y>", "\<C-u>", "\<C-i>", "\<C-o>", "\<C-p>", "\<C-z>", "\<C-x>",
      \ "\<C-c>", "\<C-v>", "\<C-b>", "\<C-n>", "\<C-m>" ]

    Plug 'hrsh7th/vim-searchx'
    nnoremap ? <Cmd>call searchx#run(0)<CR>
    nnoremap / <Cmd>call searchx#run(1)<CR>
    xnoremap ? <Cmd>call searchx#run(0)<CR>
    xnoremap / <Cmd>call searchx#run(1)<CR>

    nnoremap N <Cmd>call searchx#search_prev()<CR>
    nnoremap n <Cmd>call searchx#search_next()<CR>
    xnoremap N <Cmd>call searchx#search_prev()<CR>
    xnoremap n <Cmd>call searchx#search_next()<CR>

    let g:searchx = {}
    function g:searchx.convert(input) abort
      if a:input !~# '\k'
        return '\V' .. a:input
      endif
      let l:sep = a:input[0] =~# '[[:alnum:]]' ? '\%([^[:alnum:]]\|^\)\zs' : '\%([[:alnum:]]\|^\)\?\zs'
      return l:sep .. join(split(a:input, ' '), '.\{-}')
    endfunction

    " ファイル検索
    " 曖昧検索してくれるやつ
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " fzfのプレビュー見せてくれるやつ
    Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
        nmap <space>h <Cmd>FzfPreviewMruFilesRpc<CR>
        nmap <space>f <Cmd>FzfPreviewProjectFilesRpc<CR>
        nmap <space>g <Cmd>FzfPreviewGitActionsRpc<CR>
        nmap <Space>q <Cmd>FzfPreviewQuickFixRpc<CR>
        nmap <Space>d <Cmd>FzfPreviewVimLspDiagnosticsRpc<CR>
        nmap <Space>c <Cmd>FzfPreviewCommandPaletteRpc<CR>
        let g:fzf_preview_history_dir = '~/.config/nvim/.fzf_preview_history'

    " grepだけこっち使う
    Plug 'junegunn/fzf.vim'
      let $FZF_DEFAULT_OPTS = "--layout=reverse --info=inline --bind ctrl-b:page-up,ctrl-f:page-down,ctrl-u:up+up+up,ctrl-d:down+down+down"
      let g:fzf_history_dir = '~/.config/nvim/.fzf_history'
      let g:fzf_custom_options = ['--preview', 'bat --style=numbers --color=always --line-range :500'.' {}']
      command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --hidden -g "!{node_modules,.git}" --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview({'window': {'width': 0.9,'height': 0.9}}), <bang>0)
        nmap <Space>r <Cmd>Rg<CR>

    " Git
    Plug 'lambdalisue/gina.vim'

    " LSP
    " LSPを動かすやつ
    Plug 'prabirshrestha/vim-lsp'
    " LSPの設定を言語ごとに自動で設定してくれるやつ
    Plug 'mattn/vim-lsp-settings'
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

    " カラースキーム
    Plug 'NLKNguyen/papercolor-theme'

    " ステータスバー
    Plug 'vim-airline/vim-airline'

    " スニペット系
    " スニペットのエンジン(Python依存
    Plug 'SirVer/ultisnips'
    " スニペットがいっぱい入ってるやつ
    Plug 'honza/vim-snippets'
    " 必要なのか不明
    " Plug 'thomasfaingnaert/vim-lsp-snippets'
    " Plug 'thomasfaingnaert/vim-lsp-ultisnips'
      " タブとShiftタブでジャンプ
      let g:UltiSnipsExpandTrigger="<tab>"
      let g:UltiSnipsJumpForwardTrigger="<tab>"
      let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

    " 補完系
    " 補完するエンジン
    Plug 'prabirshrestha/asyncomplete.vim'
    " LSPの補完を流してくれる
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    " スニペットの補完を流してくれる
    Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
      " ↓ タブ打ちたい時のために切っておく
      "inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
      "inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>" 

    " テスト
    Plug 'vim-test/vim-test'
      let g:VimuxOrientation = "h"
      let g:VimuxHeight = "40"
    " テストをtmuxで開いてくれる
    Plug 'preservim/vimux'
        nmap <silent> t<C-n> :TestNearest<CR>
        nmap <silent> t<C-f> :TestFile<CR>
        nmap <silent> t<C-s> :TestSuite<CR>
        nmap <silent> t<C-l> :TestLast<CR>
        let test#strategy = "vimux"

    " Go用のプラグイン
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " vimdoc翻訳用
    Plug 'vim-jp/autofmt'

    " シンタックスハイライト
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " カッコをうまいことしてくれる
    Plug 'machakann/vim-sandwich'

call plug#end()

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
" デフォルトの256色から、もっとカラフルにするやつ
set termguicolors

" カラースキーム
colorscheme PaperColor
" ダークモードを使う
set background=dark

" vimdoc翻訳用
" https://github.com/vim-jp/vimdoc-ja-working/wiki/Guide
setlocal conceallevel=0
highlight Ignore ctermfg=red
set formatexpr=autofmt#japanese#formatexpr()
let autofmt_allow_over_tw = 1
set formatoptions+=mB
set smartindent
syntax match Error /\%>79v.*/
set colorcolumn=+1
set spell

" lightspeedのカーソル色をiterm2の色と同じにする

" ultisnipsのスニペットをasyncompleteに渡す
call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
  \ 'name': 'ultisnips',
  \ 'allowlist': ['*'],
  \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
  \ }))

" :w がどうしても :W になっちゃうので。update は変更があれば書き込んでくれる
command! W update

" Eから始まるコマンドを作るプラグイン入れると使えなくなるので（easymotionとか)
command! E Explore

" 検索のハイライトを消す
nmap <space>/ <Cmd>nohlsearch<CR>

" vim-sandwichをsurround.vimのキーマップに変更してくれる
" （sがlightspeedと競合しちゃう)
runtime macros/sandwich/keymap/surround.vim
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
  \   {'buns': ['<', '>'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['<']}
  \ ]
" さらに競合するので、Sを消す
xmap <C-s> <Plug>(sandwich-add)
xmap S <Plug>Lightspeed_S

echo "init.vimの実行時間:" reltimestr(reltime(start_time)) "s"

iab cosnt const

augroup lightspeed_colors
  autocmd!
  autocmd ColorScheme * highlight LightspeedCursor guifg=#FFFFFF guibg=#FFB472
augroup END

let g:netrw_banner = 0
