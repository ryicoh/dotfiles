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


call plugin#use('Shougo/ddc.vim')
  inoremap <silent><expr> <TAB>
    \ ddc#map#pum_visible() ? '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()
  inoremap <expr><S-TAB> ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

  call plugin#use('Shougo/ddc-around')
  call plugin#use('Shougo/ddc-matcher_head')
  call plugin#use('Shougo/ddc-sorter_rank')
  call plugin#use('shun/ddc-vim-lsp')
    call ddc#custom#patch_global('sources', ['around', 'vim-lsp'])
    call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'aro'},
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ 'vim-lsp': {
      \   'matchers': ['matcher_head'],
      \   'mark': 'lsp',
      \ },
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

cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-f> <Right>
cmap <C-b> <Left>
