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

lang en_US.UTF-8
