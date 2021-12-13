call plug#begin('~/.config/nvim/plugged')
    " deno系プラグインを使うためのやつ
    Plug 'vim-denops/denops.vim'

    " 移動
    Plug 'ggandor/lightspeed.nvim'

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
        nmap <Space>r <Cmd>FzfPreviewProjectGrepRpc<CR>
        let g:fzf_preview_history_dir = '~/.config/nvim/.fzf_preview_history'

    " LSP
    " LSPを動かすやつ
    Plug 'prabirshrestha/vim-lsp'
    " LSPの設定を言語ごとに自動で設定してくれるやつ
    Plug 'mattn/vim-lsp-settings'
        " READMEのコピペ
        function! s:on_lsp_buffer_enabled() abort
            setlocal omnifunc=lsp#complete
            setlocal signcolumn=yes
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
            autocmd! BufWritePre *.tsx,*.ts,*.rs,*.go call execute('LspDocumentFormatSync')
        endfunction

        augroup lsp_install
            au!
            autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
        augroup END

        " deno を使う場合は必要
        let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'deno']

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
        nmap <silent> t<C-l> :TestLast<CR>
        let test#strategy = "vimux"

    " Go用のプラグイン
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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

" lightspeedのカーソル色をiterm2の色と同じにする
highlight LightspeedCursor guifg=#FFFFFF guibg=#FFB472

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

" !とか使わんので、:!に変えとく
nmap ! :<C-u>!

" 検索のハイライトを消す
nmap <space>/ <Cmd>nohlsearch<CR>
