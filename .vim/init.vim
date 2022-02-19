source $VIMRUNTIME/defaults.vim


call plugin#use('vim-denops/denops.vim')

call plugin#use('prabirshrestha/vim-lsp')
call plugin#use('mattn/vim-lsp-settings')
  let g:lsp_diagnostics_float_cursor = 1
  set signcolumn=yes
  nmap ga <plug>(lsp-code-action)
  nmap gd <plug>(lsp-definition)
  nmap <leader>rn <plug>(lsp-rename)
  nmap [g <plug>(lsp-previous-diagnostic)
  nmap ]g <plug>(lsp-next-diagnostic)

call plugin#use('hrsh7th/vim-vsnip')
call plugin#use('hrsh7th/vim-vsnip-integ')
call plugin#use('rafamadriz/friendly-snippets')
  imap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
  smap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
  imap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
  smap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'

call plugin#use('Shougo/ddc.vim')
  inoremap <silent><expr> <TAB>
    \ ddc#map#pum_visible() ? '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()
  inoremap <expr><S-TAB> ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

  call plugin#use('Shougo/ddc-around')
  call plugin#use('shun/ddc-vim-lsp')
  call plugin#use('tani/ddc-fuzzy')
    call ddc#custom#patch_global('sources', ['vsnip', 'vim-lsp', 'around'])
    call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_fuzzy'],
      \   'sorters': ['sorter_fuzzy'],
      \   'converters': ['converter_fuzzy'],
      \ },
      \ 'around': {'mark': 'aro'},
      \ 'vsnip': {'mark': 'sni'},
      \ 'vim-lsp': {'mark': 'lsp'},
      \ })
    call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

  call ddc#enable()

call plugin#use('vim-test/vim-test')
  nmap <silent> t<C-n> :<C-u>TestNearest<CR>
  nmap <silent> t<C-f> :<C-u>TestFile<CR>
  nmap <silent> t<C-l> :<C-u>TestLast<CR>
  let test#strategy = "vimterminal"


set wildmenu wildmode=longest:list
set wildignore+=**/node_modules/**
set path+=src/**

syntax enable
filetype plugin indent on
colorscheme desert

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
