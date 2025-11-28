-- vim: nu fdm=marker
return {

  -- auto-save.nvim {{{
  -- https://github.com/okuuva/auto-save.nvim
  -- Automatically save changed buffers in neovim.
  {
    'okuuva/auto-save.nvim',
    version = '^1.0.0', -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
    },
  },
  -- }}}

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
    keys = {
      { "gs", mode = { "n", "x", "o" }, function() require('flash').jump() end, desc = "Flash jump." },
      -- selection base on treesitter parent+nodes
      { "gS", mode = { "n", "x", "o" }, function() require('flash').treesitter() end, desc = "Flash treesitter." },
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
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
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
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
          },
        },
      })
    end,
  },
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
      -- Make this stand out a little more.
      -- NOTE: Thu Feb 22 2024 10:02:33 font is not recongnized; at least the size 'h' isn't.
      vim.cmd[[
      hi NvimWindowLetter guifg=#ff3393 guibg=#000000 font='Impact:h22'
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

  -- lazydocker.nvim {{{
  -- https://github.com/mgierada/lazydocker.nvim
  -- https://github.com/jesseduffield/lazydocker
  --
  -- Run lazydocker inside of a floating window.
  --
  -- keybindings for lazydocker: https://github.com/jesseduffield/lazydocker/blob/master/docs/keybindings/Keybindings_en.md
  {
    "mgierada/lazydocker.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    config = function()
      require("lazydocker").setup({
        border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
      })
    end,
    event = "BufRead",
    keys = {
      {
        "<leader>ld",
        function()
          require("lazydocker").open()
        end,
        desc = "Open Lazydocker floating window",
      },
    },
  },
  -- }}}

  -- mini.align {{{
  -- https://github.com/echasnovski/mini.align
  -- Align text interactively and w/ preview.
  -- Start alignment w/ `ga` or `gA` then add alignment char.
  {
    'echasnovski/mini.align',
    version = false,
    config = function()
      require('mini.align').setup()
    end,
  },
  -- }}}

  -- TODO: Is this useful?

  -- Recover.vim {{{
  -- https://github.com/chrisbra/Recover.vim
  -- Adds the ability to (R)ecover & (C)ompare swapfiles - provided that you
  -- have enabled swapfiles.
  {
    'chrisbra/Recover.vim',
  },
  -- }}}

  -- TODO: resty.nvim vs rest.nvim

  -- rest.nvim {{{
  -- https://github.com/rest-nvim/rest.nvim
  -- A very fast, powerful, extensible and asynchronous Neovim HTTP client written in Lua.
  -- {
  --   'rest-nvim/rest.nvim',
  --   -- first load extension
  --   require("telescope").load_extension("rest")
  --   -- then use it, you can also use the `:Telescope rest select_env` command
  --   require("telescope").extensions.rest.select_env()
  -- },
  -- }}}

  -- resty.nvim {{{
  -- https://github.com/lima1909/resty.nvim
  -- A fast and easy-to-use HTTP REST client for neovim, completely in lua.
  {
    'lima1909/resty.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  -- }}}

  -- nvim-possession.nvim & scope.nvim {{{
  -- https://github.com/tiagovla/scope.nvim
  -- https://github.com/gennaro-tedesco/nvim-possession
  -- Session management & limit it to tabs with scope.nvim
  -- NOTE: Bug in neovim related to active terminal in saved sessions: https://github.com/neovim/neovim/issues/4895
  -- mention in nvim-possession -> https://github.com/gennaro-tedesco/nvim-possession/issues/32#issuecomment-1746871516
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
        vim.keymap.set("n", "<leader>pp", function()
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
            autoload = false,
            autoprompt = true,
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

  -- snacks.nvim
  -- https://github.com/folke/snacks.nvim
  -- A collection of small QoL
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = false },      -- LunarVim/bigfile offers more granularity.
      dashboard = { enabled = false },    -- needs to work w/ nvim-possession + scope to be useful.
      dim = { enabled = false },          -- TODO: workout how to toggle.
      git = { enabled = false },          -- other plugins work better.
      gitbrowse = { enabled = false },    -- Octo.nvim does it better.
      indent = { enabled = false },       -- TODO: investigate vs indent-blanckline.nvim
      input = { enabled = true },
      lazygit = { enabled = true },       -- TODO: compare w/ https://github.com/kdheepak/lazygit.nvim
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<leader>gz", function() Snacks.lazygit() end, desc = "Snacks lazygit" },
    },
  },

  -- Sort.nvim {{{
  -- https://github.com/sQVe/sort.nvim
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
  --
  -- Launch vim-startuptime with :StartupTime.
  -- Press K on events to get additional information.
  -- Press gf on sourcing events to load the corresponding file in a new split.
  -- The key sequences above can be customized (:help startuptime-configuration).
  -- Times are in milliseconds.
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
    keys = {
      { "<leader>hs", ":StartupTime", mode = {"n"}, desc = "View startup event timing information." },
    },
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
    keys = {
      -- TODO: this doesn't work for some reason.
      { "C-n", mode = { "n" }, function() require('illuminate').goto_next_reference() end,
        desc = "Illuminate Goto next illuminated reference."},
    },
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

  -- windows.nvim
  -- https://github.com/anuvyklack/windows.nvim
  -- This is like the C-b z "zoom" feature of tmux where you can zoom in on a
  -- single window.
  -- Automatically expand the width of the current window
  -- Maximizes and restores the current window.
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      -- setup some animaation.
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end,
    keys = {
      { "<C-w>z", "<Cmd>WindowsMaximize<cr>", mode = {"n"},
      desc = "Maximize the current window or restore previous windows."},
      -- Turn this off if we dont really are about the animation.
      { "<C-w>=", "<Cmd>WindowsEqualize<cr>", mode = {"n"},
      desc = "Make all windows (almost) equally high and wide (see :he CTRL-W_=)"},
    },
  },

  -- arrow.nvim {{{
  -- https://github.com/otavioschwanck/arrow.nvim
  -- Arrow.nvim is a plugin made to bookmarks files (like harpoon) using a single UI (and single keymap).
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {
      show_icons = true,
      separate_by_branch = false, -- Bookmarks will be separated by git branch
      leader_key = ',',           -- Recommended to be a single key - I already use ';' as my localleader
      buffer_leader_key = 'm',    -- Per Buffer Mappings
      per_buffer_config = {
        lines = 2,
      },
    }
  },
  -- }}}

  -- mini.splitjoin {{{
  -- https://github.com/echasnovski/mini.splitjoin?tab=readme-ov-file
  {
    'echasnovski/mini.splitjoin',
    version = false,
    config = function()
      require('mini.splitjoin').setup({
        mappings = {
          toggle = 'gj',
        }
      })
    end,
  },
  -- }}}

  -- mini.ai {{{
  -- https://github.com/echasnovski/mini.ai
  -- Extend and create a/i textobjects.
  --
  -- It enhances some builtin textobjects (like a(, a), a', and more), creates
  -- new ones (like a*, a<Space>, af, a?, and more), and allows user to create
  -- their own (like based on treesitter, and more).
  --
  -- Supports dot-repeat,
  -- v:count, different search methods, consecutive application, and
  -- customization via Lua patterns or functions.
  --
  -- Has builtins for brackets,
  -- quotes, function call, argument, tag, user prompt, and any
  -- punctuation/digit/whitespace character.
  --
  -- Includes treesitter textobjects.
  {
    'echasnovski/mini.ai',
    version = false,
    config = function()
      require('mini.ai').setup({
        n_lines = 75,
      })
    end,
  },
  -- }}}

}
