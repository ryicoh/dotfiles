local actions = require("telescope.actions")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },
    history = {
      limit = 10000,
    }
  },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}

require("telescope").load_extension("ui-select")
require('telescope').load_extension('live_grep_raw')
require('telescope').load_extension('gh')

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>f', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>r', '<cmd>Telescope live_grep<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>b', '<cmd>Telescope buffers<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>h', '<cmd>Telescope oldfiles<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>c', '<cmd>Telescope command_history<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>/', '<cmd>Telescope search_history<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>Telescope quickfix<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>d', '<cmd>Telescope diagnostics<cr>', opts)
