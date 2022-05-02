if has('nvim')
  let &runtimepath = "~/.vim," . &runtimepath
else
  let &t_SI = "\e[6 q"
  let &t_EI = "\e[2 q"
endif


let s:default_vim = $VIMRUNTIME."/defaults.vim"
if filereadable(s:default_vim)
  exec "source " . s:default_vim
endif

call plugin#use('vim-denops/denops.vim')

" let g:sneak#label = 1
" call plugin#use('justinmk/vim-sneak')
" call plugin#use('ryicoh/session.vim')
" augroup session
" 	au!
" 	au VimEnter * call session#restore()
" 	au VimLeave * call session#save()
" augroup end

call plugin#use('prabirshrestha/vim-lsp')
call plugin#use('mattn/vim-lsp-settings')
" call plugin#use('tsuyoshicho/vim-efm-langserver-settings')
  " let g:lsp_settings = {
  " \   'efm-langserver': {'disabled': v:false}
  " \ }
  let g:lsp_diagnostics_float_cursor = 1
  " let g:lsp_settings_filetype_typescript = ['deno']
  let &signcolumn = 'yes'
  nmap ga <plug>(lsp-code-action)
  nmap gd <plug>(lsp-definition)
  nmap gr <plug>(lsp-references)
  nmap <leader>rn <plug>(lsp-rename)
  nmap [g <plug>(lsp-previous-diagnostic)
  nmap ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)

" call plugin#use('hrsh7th/vim-vsnip')
" call plugin#use('hrsh7th/vim-vsnip-integ')
" call plugin#use('rafamadriz/friendly-snippets')
"   imap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
"   smap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
"   imap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
"   smap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
" 
call plugin#use('Shougo/ddc.vim')
  call plugin#use('shun/ddc-vim-lsp')
  call plugin#use('Shougo/ddc-around')
  call plugin#use('Shougo/ddc-rg')
  call plugin#use('tani/ddc-fuzzy')
     call ddc#custom#patch_global('sources', ['vim-lsp', 'around', 'rg'])
     call ddc#custom#patch_global('sourceOptions', {
       \ '_': {
       \   'matchers': ['matcher_fuzzy'],
       \   'sorters': ['sorter_fuzzy'],
       \   'converters': ['converter_fuzzy'],
       \ },
       \ 'around': {'mark': 'aro'},
       \ 'vsnip': {'mark': 'sni'},
       \ 'vim-lsp': {'mark': 'lsp', 'forceCompletionPattern': '\..?'},
       \ 'rg': {'mark': 'rg', 'minAutoCompleteLength': 4},
       \ })

    inoremap <silent><expr> <TAB>
      \ ddc#map#pum_visible() ? '<C-n>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()
    inoremap <silent><expr> <S-TAB> ddc#map#pum_visible() ? '<C-p>' : '<C-h>'
    inoremap <silent><expr> <C-x><C-d> ddc#map#manual_complete()

  call ddc#enable()

call plugin#use('vim-test/vim-test')
  nmap <silent> t<C-n> :<C-u>TestNearest<CR>
  nmap <silent> t<C-f> :<C-u>TestFile<CR>
  nmap <silent> t<C-l> :<C-u>TestLast<CR>
  let test#strategy = "vimterminal"

let s:deepl_auth_key_path = expand("~/.vim/deepl_auth_key.txt")
if filereadable(s:deepl_auth_key_path)
  call plugin#use('ryicoh/deepl.vim')
  let g:deepl#endpoint = "https://api-free.deepl.com/v2/translate"
  let g:deepl#auth_key = readfile(s:deepl_auth_key_path)[0]
  vmap t<C-e> <Cmd>call deepl#v("EN")<CR>
  vmap t<C-j> <Cmd>call deepl#v("JA")<CR>
endif
 
"set completeopt=menuone,longest,preview
set wildignore+=**/node_modules/**,**/build/**,**/storybook-static/**,**/target/**,**/dist/**
set path+=src/**,pkg/**,cmd/**,app/**,~/.vim/**

syntax enable
filetype plugin indent on
colorscheme evening

let &termguicolors = v:true
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let &grepprg = "rg --vimgrep --hidden"

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

set pumheight=24
inoremap <expr> <C-u> pumvisible() ? repeat("\<C-p>", 12) : "\<C-u>"
inoremap <expr> <C-d> pumvisible() ? repeat("\<C-n>", 12) : "\<C-d>"

augroup scss
  au!
  au BufRead *.css set filetype=scss
augroup END

" call plugin#use("neoclide/coc.nvim", {'branch': 'release'})
" nmap <silent> gd <Plug>(coc-definition)
