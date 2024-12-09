return {

  -- bigfile.nvim {{{
  -- https://github.com/LunarVim/bigfile.nvim
  -- Automatically disable certain features if the opened file is really big.
  -- Everythingˆs configurable.
  {
    'LunarVim/bigfile.nvim',
    config = function()
      require("bigfile").setup({
        filesize = 4, -- size of the file in MiB, rounds to the closest MiB
        features = {
          "indent_blankline",
          "illuminate",
          "lsp",
          "treesitter",
          "vimopts",
        },

      -- detect really long python files explicitly
      pattern = function(bufnr, filesize_mib)
        -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
        local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
        local file_length = #file_contents
        local filetype = vim.filetype.match({ buf = bufnr })
        if file_length > 15000 and filetype == "python" then
          return true
        end
      end

      })
    end
  },
    -- }}}

  -- bufdelete {{{
  -- https://github.com/famiu/bufdelete.nvim
  -- Delete buffers without trashing my window layout.
  {
    'famiu/bufdelete.nvim',
  },
  -- }}}

  -- dial.nvim {{{
  -- https://github.com/monaqa/dial.nvim
  -- Increment/decrment number, constants, datetime, versions.
  -- Overrides the default C-a/C-x bindings in Neovim.
  -- TODO: Investigate different filetype constants for booleans, e.g. Python capital vs. lua lowercase.
  {
    "monaqa/dial.nvim",
  },
  --   }}}

  -- flash.nvim {{{
  -- https://github.com/folke/flash.nvim
  -- Navigate more like avy (Emacs package)
  -- TODO: explore flash.nvim navigation, e.g. treesitter
  {
    'folke/flash.nvim',
    event = "VeryLazy",
    opts = {
      -- give labels to fF/tT motions.
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
  -- }}}

  -- helpview.nvim {{{
  -- https://github.com/OXY2DEV/helpview.nvim
  -- Make help docs look a little brighter.
  {
    "OXY2DEV/helpview.nvim",
    lazy = false, -- Recommended

    -- In case you still want to lazy load
    -- ft = "help",

    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
  },
  -- }}}

  -- Neotree {{{
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  --
  -- Tracking ticket for document_symbols feature.
  -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/879
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()

      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require("neo-tree").setup({
        close_if_last_window = true,
        sources = {
          "filesystem",
          "git_status",
          "document_symbols",
        },
      })
    end,
  },
  -- }}}

  -- neovim-project {{{
  -- https://github.com/coffebar/neovim-project
  -- Neovim project plugin simplifies project management by maintaining project
  -- history and providing quick access to saved sessions via Telescope. It runs on
  -- top of the Neovim Session Manager, which is needed to store all open tabs and
  -- buffers for each project.
  --
  --     ✅ Start where you left off last time.
  --     ✅ Switch from project to project in second.
  --     ✅ Sessions and history can be synced across your devices (rsync, Syncthing, Nextcloud, Dropbox, etc.)
  --     ✅ Find all your projects by glob patterns defined in config.
  --     ✅ Autosave neo-tree.nvim expanded directories and buffers order in barbar.nvim.
  --
  -- Neovim project manager will add these commands:
  --
  --     :Telescope neovim-project discover - find a project based on patterns.
  --     :Telescope neovim-project history - select a project from your recent history.
  --     :NeovimProjectLoadRecent - open the previous session.
  --     :NeovimProjectLoadHist - opens the project from the history providing a project dir.
  --     :NeovimProjectLoad - opens the project from all your projects providing a project dir.
  --
  -- History is sorted by access time. "Discover" keeps order as you have in the config.
  -- Telescope mappings
  -- Use Ctrl+d in Telescope to delete the project's session and remove it from the history.
  -- {
  --   "coffebar/neovim-project",
  --   opts = {
  --     projects = { -- define project roots
  --     },
  --   },
  --   init = function()
  --     -- enable saving the state of plugins in the session
  --     vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  --   end,
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim" },
  --     { "nvim-telescope/telescope.nvim"},
  --     { "Shatur/neovim-session-manager" },
  --   },
  --   lazy = false,
  --   priority = 100,
  -- },
  -- }}}

  -- numb.nvim {{{
  -- https://github.com/nacro90/numb.nvim
  -- Peeking the buffer while entering command :{number}
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  },
  -- }}}

  -- nvim-colorizer.lua {{{
  -- Show the color of the rgb code.
  -- https://github.com/NvChad/nvim-colorizer.lua
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({
          filetypes = {
            'lua',
            'css',
            'vim',
            html = { mode = 'foreground', }
          },
        })
    end,
  },
  -- }}}

  -- nvim-surround {{{
  -- https://github.com/kylechui/nvim-surround
  -- The three "core" operations of add/delete/change can be done with the keymaps
  -- ys{motion}{char}, ds{char}, and cs{target}{replacement}, respectively. For the
  -- following examples, * will denote the cursor position:
  --
  --     Old text                    Command         New text
  -- --------------------------------------------------------------------------------
  --     surr*ound_words             ysiw)           (surround_words)
  --     *make strings               ys$"            "make strings"
  --     [delete ar*ound me!]        ds]             delete around me!
  --     remove <b>HTML t*ags</b>    dst             remove HTML tags
  --     'change quot*es'            cs'"            "change quotes"
  --     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
  --     delete(functi*on calls)     dsf             function calls
  --
  {
    'kylechui/nvim-surround',
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end,
  },
  -- }}}

  -- nvim-ufo {{{
  -- https://github.com/kevinhwang91/nvim-ufo
  -- faster folding.
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()

      -- Use treesitter as the main fold provider.
      require('ufo').setup({
          provider_selector = function(bufnr, filetype, buftype)
            return {'treesitter', 'indent' }
          end
        })
    end,
  },
  -- }}}

  -- nvim-window {{{
  -- https://gitlab.com/yorickpeterse/nvim-window
  -- Switch between windows ace-window style.
  {
    'https://gitlab.com/yorickpeterse/nvim-window.git',
    config = function()
      require('nvim-window').setup({
        normal_hl = 'NvimWindowLetter',
        hint_hl = 'Bold',
        border = 'single',
        -- keep the chars on the home row.
        chars = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';'}
      })
      -- NOTE: Thu Feb 22 2024 10:02:33 font is not recongnized; at least the size 'h' isn't.
      vim.cmd[[
      hi NvimWindowLetter guifg=#ff3393 guibg=#1e2030 font='Impact:h22'
      ]]
    end,
  },
  -- }}}

  -- gx.nvim {{{
  -- https://github.com/chrishrb/gx.nvim
  -- Open URLs, search words in search engine, github issues.
  -- TODO: modify to search in HPE github.
  {
    "chrishrb/gx.nvim",
    keys = {
      { "gx", "<cmd>Browse<cr>", mode = { "n", "x" }, desc = "Browse URLs, search words." },
      { "gX", ":Browse ", mode = { "n", "x" }, desc = "Browse URLs, search words." }
    },
    cmd = { "Browse" },
    init = function ()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("gx").setup {
      handlers = {
        package_json = false,
      },
    } end,
  },
  -- }}}

  -- Recover.vim {{{
  -- https://github.com/chrisbra/Recover.vim
  -- Adds the ability to (R)ecover & (C)ompare swapfiles - provided that you
  -- have enabled swapfiles.
  {
    'chrisbra/Recover.vim',
  },
  -- }}}

  -- repolink.nvim
  -- https://github.com/9seconds/repolink.nvim
  -- Helps you to link a file or a line range in a file to some URL that you
  -- can use to share with your colleagues.
  {
    "9seconds/repolink.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    cmd = {
      "RepoLink"
    },

    config = function()
      require("repolink").setup({
        -- your configuration goes here.
        -- keep empty object if you are fine with defaults
        url_builders = {
          ["github.hpe.com"] = require("repolink").url_builder_for_github("https://github.hpe.com"),
        },
      })
    end,
  },

  -- nvim-possession.nvim & scope.nvim {{{
  -- https://github.com/tiagovla/scope.nvim
  -- https://github.com/gennaro-tedesco/nvim-possession
  -- Session management & limit it to tabs with scope.nvim
  {
    "gennaro-tedesco/nvim-possession",
    lazy = false,
    dependencies = {
        {
            "tiagovla/scope.nvim",
            lazy = false,
            config = true,
        },
        { "ibhagwan/fzf-lua" },
    },
    init = function()
      local possession = require("nvim-possession")
        vim.keymap.set("n", "<leader>pl", function()
            possession.list()
        end, { desc = "List saved nvim-possession sessions." })
        vim.keymap.set("n", "<leader>pn", function()
            possession.new()
        end, { desc = "Create new nvim-possession session." })
        vim.keymap.set("n", "<leader>pu", function()
            possession.update()
        end, { desc = "Update the current nvim-possession session." })
        vim.keymap.set("n", "<leader>pd", function()
            possession.delete()
        end, { desc = "Delete the current nvim-possession session." })
    end,
    config = function()
        require("nvim-possession").setup({
            autoload = true,
            autoswitch = {
                enable = true,
            },
            save_hook = function()
                vim.cmd([[ScopeSaveState]]) -- Scope.nvim saving
            end,
            post_hook = function()
                vim.cmd([[ScopeLoadState]]) -- Scope.nvim loading
            end,
        })
    end,
  },
  -- }}}

  -- scratch.nvim {{{
  -- https://github.com/LintaoAmons/scratch.nvim
  -- Create temporary files.
  {
    'LintaoAmons/scratch.nvim',
    event = "VeryLazy",
    dependencies = {
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("scratch").setup({
        scratch_file_dir = "~/WorkStuff/hpe_home",
        window_cmd = "rightbelow vsplit",
        use_telescope = false,
        file_picker = "fzf_lua",
        filetypes = { "md" },
      })
    end,
    keys = {
      { "<leader>cs", ":Scratch<cr>", mode = {"n"}, desc = "Create new scratch file in scratch_file_dir" },
      { "<leader>cn", ":ScratchWithName<cr>", mode = {"n"}, desc = "Create new scratch file w/ name." },
      { "<leader>cf", ":ScratchOpenFzf<cr>", mode = {"n"}, desc = "Use fzf to open scratch file." },
    },
  },
  -- }}}

  -- Sort.nvim {{{
  -- Line-wise and delimiter sorting NOT alignment.
  {
    'sQVe/sort.nvim',

    -- Optional setup for overriding defaults.
    config = function()
      require("sort").setup({
        -- Input configuration here.
      })
    end,
  },
  -- }}}

  -- vim-startuptime {{{
  -- https://github.com/dstein64/vim-startuptime
  -- View startup event timing information.
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- vim-cool {{{
  -- https://github.com/romainl/vim-cool
  -- Vim-cool disables search highlighting when you are done searching and
  -- re-enables it when you search again.
  {
    'romainl/vim-cool',
  },
  -- }}}

  -- vim-illuminate {{{
  -- https://github.com/RRethy/vim-illuminate
  -- TODO: fix the highlighting for vim-illuminate.
  -- hi def IlluminatedWordText gui=bold ctermbg=<some light pink>
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        providers = {
          'lsp',
          'treesitter',
        },
        filetypes_allowlist = { "clojure", "commonlisp", "go", "help", "lua", "nim", "Python", "rust" },
        large_file_cutoff = 25000,
      })
    end,
  },
  -- }}}

  -- vim-unimpaired {{{
  -- https://github.com/tpope/vim-unimpaired
  -- [<space> - Add [count] blank lines above the cursor.
  -- ]<space> - Add [count] blank lines below the cursor.
  -- [e - Exchange the current line with [count] lines above it.
  -- ]e - Exchange the current line with [count] lines below it.
  {'tpope/vim-unimpaired'},
  -- }}}

  -- which-key {{{
  -- https://github.com/folke/which-key.nvim
  -- Display keybindings.
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },
  -- }}}

}
