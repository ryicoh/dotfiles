require 'lightspeed'.setup {
  ignore_case = true,
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 's', '<Plug>Lightspeed_s', opts)
vim.api.nvim_set_keymap('n', 'S', '<Plug>Lightspeed_S', opts)
vim.api.nvim_set_keymap('x', 's', '<Plug>Lightspeed_x', opts)
vim.api.nvim_set_keymap('x', 'S', '<Plug>Lightspeed_X', opts)
