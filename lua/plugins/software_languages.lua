-- vim: nu fdm=marker
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
    config = function()
      vim.cmd[[
        let g:conjure_log_wrap=v:true
      ]]
    end,
  },

  -- FIXME: Mon Apr 07 2025 17:19:59 -> THis is not working w/ 0.11 for some reason.
  -- nvim-treesitter-sexp {{{
  -- https://github.com/PaterJason/nvim-treesitter-sexp
  -- {
  --   'PaterJason/nvim-treesitter-sexp',
  --   config = function()
  --     require("treesitter-sexp").setup {
  --       -- Enable/disable
  --       enabled = true,
  --       -- Move cursor when applying commands
  --       set_cursor = true,
  --       -- Set to false to disable all keymaps
  --       keymaps = {
  --         -- Set to false to disable keymap type
  --         commands = {
  --           -- Set to false to disable individual keymaps
  --           swap_prev_elem = "<e",
  --           swap_next_elem = ">e",
  --           swap_prev_form = "<f",
  --           swap_next_form = ">f",
  --           promote_elem = "<LocalLeader>O",
  --           promote_form = "<LocalLeader>o",
  --           splice = "<LocalLeader>@",
  --           slurp_left = "<(",
  --           slurp_right = ">)",
  --           barf_left = ">(",
  --           barf_right = "<)",
  --           insert_head = "<I",
  --           insert_tail = ">I",
  --         },
  --         motions = {
  --           form_start = "(",
  --           form_end = ")",
  --           prev_elem = "[e",
  --           next_elem = "]e",
  --           prev_elem_end = "[E",
  --           next_elem_end = "]E",
  --           prev_top_level = "[[",
  --           next_top_level = "]]",
  --         },
  --         textobjects = {
  --           inner_elem = "ie",
  --           outer_elem = "ae",
  --           inner_form = "if",
  --           outer_form = "af",
  --           inner_top_level = "iF",
  --           outer_top_level = "aF",
  --         },
  --       },
  --     }
  --   end,
  -- },
  -- }}}

  -- Clojure {{{

  -- {
  --   'liquidz/vim-iced',
  -- },

  -- nvim-paredit
  -- https://github.com/julienvincent/nvim-paredit
  -- s-expression editing experience comparible to paredit on Emacs.
  --
  -- Provides:
  --    - Treesitter based lisp structural editing, cursor motions and text object selections
  --    - Dot-repeatable keybindings
  --    - Language extensibility
  --    - Programmable API
  -- TODO: Tue Aug 05 2025 16:09:05 - need to uncomment and compare to vim-sexp
  -- {
  --   "julienvincent/nvim-paredit",
  --   config = function()
  --     local paredit = require("nvim-paredit")
  --     paredit.setup({
  --       filetypes = {"clojure", "lisp"},
  --       keys = {
  --         ["<localleader>r"] = { paredit.api.raise_form, "Raise form" },
  --       },
  --     })
  --   end
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
  -- https://gitlab.com/HiPhish/quicklisp.nvim
  -- }}}

  -- CSV {{{

  -- csvview.nvim {{{
  -- https://github.com/hat0uma/csvview.nvim
  {
    'hat0uma/csvview.nvim',
    opts = {
      parser = {
        comments = { "#", "//" },
        quote_char = '"',
        display_mode = "border",
        sticky_header = {
          enabled = true,
          separator = "-",
        },
      },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
  -- }}}

  -- rainbow_csv.nvim {{{
  -- https://github.com/cameron-wags/rainbow_csv.nvim?tab=readme-ov-file
  -- {
  --   'cameron-wags/rainbow_csv.nvim',
  --   config = true,
  --   ft = {
  --       'csv',
  --       'tsv',
  --       'csv_semicolon',
  --       'csv_whitespace',
  --       'csv_pipe',
  --       'rfc_csv',
  --       'rfc_semicolon'
  --   },
  --   cmd = {
  --       'RainbowDelim',
  --       'RainbowDelimSimple',
  --       'RainbowDelimQuoted',
  --       'RainbowMultiDelim'
  --   }
  -- },
  -- }}}

  -- }}}

  -- Golang {{{

  -- a plugin for converting JSON to Go type annotations.
  -- https://www.reddit.com/r/neovim/comments/1phmb1m/gophernvim_improve_golang_development_experience/

  -- go.nvim {{{
  -- https://github.com/ray-x/go.nvim
  -- A modern go neovim plugin.
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- lsp_keymaps = false,
      -- other options
    },
    config = function(lp, opts)
      require("go").setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
        require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  -- }}}

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
  -- https://github.com/linux-cultist/venv-selector.nvim
  -- Selects Python virtual environments - venv, conda, etc.
  {
    'linux-cultist/venv-selector.nvim',
    branch = 'main',
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

  -- rustaceanvim {{{
  -- https://github.com/mrcjkb/rustaceanvim
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  -- }}}

  -- }}}


}
