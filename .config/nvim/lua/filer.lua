local actions = require("telescope.actions")

local function action_n_times(act, times)
  local acts = act
  for _ = 1, times do
    acts = acts + act
  end

  return acts
end

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-f>"] = action_n_times(actions.move_selection_next, 10),
        ["<C-b>"] = action_n_times(actions.move_selection_previous, 10),
      }
    },
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    history = {
      limit = 10000,
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")
require('telescope').load_extension('live_grep_args')
-- require('telescope').load_extension('gh')

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>f', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>r', '<cmd>Telescope live_grep<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>b', '<cmd>Telescope buffers<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>h', '<cmd>Telescope oldfiles<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>c', '<cmd>Telescope command_history<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>/', '<cmd>Telescope search_history<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>Telescope quickfix<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>d', '<cmd>Telescope diagnostics<cr>', opts)
