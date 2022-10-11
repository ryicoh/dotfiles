lua require('plugins')

command! E Explore
set signcolumn=yes

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

set tabstop=2
set shiftwidth=2
set expandtab
set number

set updatetime=200

lang en_US.UTF-8

set formatexpr=autofmt#japanese#formatexpr()
let autofmt_allow_over_tw = 1
set formatoptions+=mB
set smartindent
