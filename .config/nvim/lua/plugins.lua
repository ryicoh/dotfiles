require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    "hrsh7th/nvim-cmp",
    requires = { {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "rafamadriz/friendly-snippets",
    } },
    config = function()
      require("completion")
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = { { 'williamboman/nvim-lsp-installer' } },
    config = function()
      require("lsp")
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-live-grep-raw.nvim',
      'nvim-telescope/telescope-github.nvim',
    } },
    config = function()
      require("filer")
    end
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'ggandor/lightspeed.nvim',
    setup = function()
      vim.g['lightspeed_no_default_keymaps'] = true
    end,
    config = function()
      require("motion")
    end
  }

  use {
    'vim-test/vim-test',
    config = function()
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', 't<c-n>', '<cmd>TestNearest<cr>', opts)
      vim.api.nvim_set_keymap('n', 't<C-n>', '<cmd>TestNearest<cr>', opts)
      vim.api.nvim_set_keymap('n', 't<C-f>', '<cmd>TestFile<cr>', opts)
      vim.api.nvim_set_keymap('n', 't<C-l>', '<cmd>TestLast<cr>', opts)

      vim.g['test#strategy'] = "neovim"
    end
  }

  use {
    'ryicoh/deepl.vim',
    config = function()
      vim.g['deepl#endpoint'] = "https://api-free.deepl.com/v2/translate"
      vim.g['deepl#auth_key'] = io.lines(vim.fn.expand("~/.vim/deepl_auth_key.txt"))()

      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('v', 't<C-e>', '<cmd>call deepl#v("EN")<cr>', opts)
      vim.api.nvim_set_keymap('v', 't<C-j>', '<cmd>call deepl#v("JA")<cr>', opts)
    end
  }

  use {
    'sainnhe/everforest',
    config = function()
      vim.cmd([[ colorscheme everforest ]])
    end,
  }

  use {
    'airblade/vim-gitgutter',
    config = function()
      vim.g.gitgutter_map_keys = 0
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', '<leader>n', '<Plug>(GitGutterNextHunk)', opts)
      vim.api.nvim_set_keymap('n', '<leader>p', '<Plug>(GitGutterPrevHunk)', opts)
      vim.api.nvim_set_keymap('n', '<leader>s', '<Plug>(GitGutterStageHunk)', opts)
      vim.api.nvim_set_keymap('n', '<leader>u', '<Plug>(GitGutterUndoHunk)', opts)
    end,
  }

  use {
    'tpope/vim-fugitive',
    requires = { {
      'tpope/vim-rhubarb'
    } }
  }

  use {
    'sebdah/vim-delve'
  }

  use {
    'jparise/vim-graphql'
  }

  use {
    'vim-jp/autofmt',
  }

  use {
    'fatih/vim-go',
  }

  use {
    'ConradIrwin/vim-bracketed-paste'
  }
  use {
    'andymass/vim-matchup',
    config = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  }
end)
