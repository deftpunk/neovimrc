return {

  -- Conjure
  -- An interactive environment for evaluating code within your program
  --
  -- Quickstarts for CL, Clojure (nREPL & babashka)
  -- https://github.com/Olical/conjure/wiki/Quick-start:-Common-Lisp-(Swank)
  -- https://github.com/Olical/conjure/wiki/Quick-start:-Clojure
  -- https://github.com/Olical/conjure/wiki/Quick-start:-Clojure-(babashka)
  {
    'Olical/conjure',
    ft = { "clojure", "python" },
    lazy = true,
  },

  -- Clojure {{{

  -- {
  --   'liquidz/vim-iced',
  -- },

  -- vim-repeat
  -- https://github.com/tpope/vim-repeat
  -- Repeat various actions.
  {'tpope/vim-repeat'},

  -- vim-sexp
  -- https://github.com/guns/vim-sexp
  -- Precision editing of S-expressions in Clojure, Common Lisp
  {'guns/vim-sexp'},

  -- vim-sexp-mappings-for-regular-people
  -- https://github.com/tpope/vim-sexp-mappings-for-regular-people
  -- Make the sexp mappings easier in the beginning.
  {'tpope/vim-sexp-mappings-for-regular-people'},

  -- The stuff to be able to Jack-in like CIDER does for Emacs - use :Clj
  {'tpope/vim-dispatch'},
  {'clojure-vim/vim-jack-in'},
  {'radenling/vim-dispatch-neovim'},

  -- }}}

  -- Common Lisp {{{

  -- }}}

  -- Nim {{{
  {
    'alaviss/nim.nvim',
  },
  -- }}}

  -- Perl {{{
  -- https://climatechangechat.com/setting_up_lsp_nvim-lspconfig_and_perl_in_neovim.html

  -- }}}

  -- Python {{{

  -- requirements.txt.vim {{{
  -- https://github.com/raimon49/requirements.txt.vim
  -- the Requirements File Format syntax support for Vim
  {
    'raimon49/requirements.txt.vim'
  },
  -- }}}

  -- venv-selector {{{
  -- https://github.com/linux-cultist/venv-selector.nvim/tree/regexp
  -- Selects Python virtual environments - venv, conda, etc.
  -- *Use the regexp branch cuz its maintained.
  {
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      auto_refresh = true,
      anaconda_base_path = '/Users/bodine/miniconda3',
      anaconda_envs_path = '/Users/bodine/miniconda3/envs',
    },
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping... which i do.
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
  },
  -- }}}

  -- }}}

  -- Rust {{{

  -- }}}


}
