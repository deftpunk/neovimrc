-- vim: nu fdm=marker

return {

  -- Comment.nvim {{{
  -- https://github.com/numToStr/Comment.nvim
  -- Comment/Uncomment plugin - successor to kommentary.
  --
  -- Supports treesitter. Read more
  -- Supports commentstring. Read :h comment.commentstring
  -- Supports line (//) and block (/* */) comments
  -- Dot (.) repeat support for gcc, gbc and friends
  -- Count support for [count]gcc and [count]gbc
  -- Left-right (gcw gc$) and Up-Down (gc2j gc4k) motions
  -- Use with text-objects
  -- Supports pre and post hooks
  -- Ignore certain lines, powered by Lua regex
  --
  -- NORMAL mode
  -- `gcc` - Toggles the current line using linewise comment
  -- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
  -- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
  -- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
  --
  -- VISUAL mode
  -- gc - Toggles the region using linewise comment.
  --
  -- EXTRA
  -- gco - Insert comment to the next line & enters INSERT mode.
  -- gc0 - Insert comment to the previous line & enters INSERT mode.
  -- gcA - Insert comment to the end of the current line & enters INSERT mode.
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        -- TODO: figure out the mapping.
        -- ignore = '^$',  -- ignore empty lines.
        -- toggler = {
        --   line = '<leader>cc',
        --   block = '<leader>bc',
        -- },
        -- opleader = {
        --   line = '<leader>c',
        --   block = '<leader>b',
        -- },
      })
    end,
  },
  -- }}}

  -- comment-box.nvim {{{
  -- https://github.com/LudoPinelli/comment-box.nvim
  -- Make comment boxes, lines & other things to make comments "pop" better.
  --
  -- Select existing line/paragraph
  -- :CBllbox1
  --
  -- Title comment:
  -- type title in INSERT mode
  -- Visually select
  -- :CBllline6
  --
  -- Simple line separator:
  -- :CBllline
  {
    'LudoPinelli/comment-box.nvim',
    keys = {
      { "<leader>cl", ":CBllline", mode = { "n" }, desc = "Simple line separator." },
    },
  },
  -- }}}

  -- indent-blankline {{{
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  -- Highlight indentation guides.
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup({
        scope = { highlight = highlight },
        -- scope = { enabled = true },
      })
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  -- }}}

  -- iron.nvim {{{
  -- https://github.com/Vigemus/iron.nvim
  -- Interactive REPLs over Neovim -> get a REPL
  -- NOTE: Mon Feb 03 2025 09:17:28 - trying this out for ipython/python instead of Conjure.
  {
    'Vigemus/iron.nvim',
    config = function(plugins, opts)

      local iron = require('iron.core')
      local view = require('iron.view')
      local common = require('iron.fts.common')

      iron.setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            python = require('iron.fts.python').ipython,
          },
          repl_open_cmd = "vertical botright 80 split",
        },
        keymaps = {
          toggle_repl = "<space>rr",
          restart_repl = "<space>rR", -- calls `IronRestart` to restart the repl
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_paragraph = "<space>sp",
          send_until_cursor = "<space>su",
          send_mark = "<space>sm",
          send_code_block = "<space>sb",
          send_code_block_and_move = "<space>sn",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
      }
    end,
  },
  -- }}}

  -- TODO: debugmaster.nvim?

  -- lazydev.nvim {{{
  -- https://github.com/folke/lazydev.nvim
  -- lazydev.nvim is a plugin that properly configures LuaLS for editing your
  -- Neovim config by lazily updating your workspace libraries.
  --
  -- I am primarily using it as a dependency for nvim-dap, nvim-dap-ui
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        "nvim-dap-ui",
      },
    },
  },
  -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
  -- }}}

  -- nvim-dap & nvim-dap-ui {{{
  -- https://github.com/rcarriga/nvim-dap-ui
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  },
    -- }}}

  -- neotest {{{
  -- Run tests from within neovim
  -- https://github.com/nvim-neotest/neotest
  -- TODO: Clean up keymaps for calling tests and displaying output.
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      -- test adapters.
      'rouge8/neotest-rust',
      'nvim-neotest/neotest-python',
    },
    lazy = true,
    config = function()
      require("neotest").setup({
          adapters = {
            -- https://github.com/nvim-neotest/neotest-python
            require("neotest-python")({
              runner = "pytest",
              args = { "-svvv" },
              dap = { justMyCode = false },
            }),
          },
      })
    end,
  },
  -- }}}

  -- Auto pairs {{{
  -- https://github.com/windwp/nvim-autopairs
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
          disable_filetype = { "TelescopePrompt" },
          enable_check_bracket_line = false,
        })
    end,
  },
  -- }}}

  -- Devdocs.nvim {{{
  -- https://github.com/maskudo/devdocs.nvim
    {
     "maskudo/devdocs.nvim",
    lazy = false,
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "DevDocs" },
    keys = {
      {
        "<leader>ho",
        mode = "n",
        "<cmd>DevDocs get<cr>",
        desc = "Get Devdocs",
      },
      {
        "<leader>hi",
        mode = "n",
        "<cmd>DevDocs install<cr>",
        desc = "Install Devdocs",
      },
      {
        "<leader>hv",
        mode = "n",
        function()
          local devdocs = require("devdocs")
          local installedDocs = devdocs.GetInstalledDocs()
          vim.ui.select(installedDocs, {}, function(selected)
            if not selected then
              return
            end
            local docDir = devdocs.GetDocDir(selected)
            -- prettify the filename as you wish
            Snacks.picker.files({ cwd = docDir })
          end)
        end,
        desc = "Get Devdocs",
      },
      {
        "<leader>hd",
        mode = "n",
        "<cmd>DevDocs delete<cr>",
        desc = "Delete Devdoc",
      }
    },
    opts = {
      ensure_installed = {
        "go",
        "nim",
        "rust",
        -- some docs such as lua require version number along with the language name
        -- check `DevDocs install` to view the actual names of the docs
        "clojure~1.11",
        "lua~5.1",
        "openjdk~21",
        "python~3.14",
        "python~3.12",
      },
    },
  },
  -- }}}

  -- nvim-lint {{{
  -- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file
  -- An asynchronous linter plugin complementary to the built-in Language Server Protocol support.
  {
    'mfussenegger/nvim-lint',
    event = {
      "BufReadPre",
      "BufNewFile",
      "BufWritePost",
      "InsertLeave"
    },
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        python = { "ruff", "flake8" },
      }

      -- Args for flake8
      -- FYI, if you add arguments to an existing linter, you have to also keep
      -- all of the existing linter arguments in the nvim-lint source. eg. the
      -- one for the flake8 liniter is here:
      -- https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/flake8.lua
      local flake8_linter = require('lint').linters.flake8
      flake8_linter.args = {
        '--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s',
        '--no-show-source',
        '--max-line-length=180',
        '--stdin-display-name',
        function() return vim.api.nvim_buf_get_name(0) end,
        '-',
      }

      -- TODO: finish off the custom ruff linter.
      -- Args for ruff
      local ruff_linter = lint.linters.ruff
      ruff_linter.args = {
        '--line-length=180'
      }

      -- Set up autocmd.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  -- }}}

  -- outline.nvim {{{
  -- https://github.com/hedyhli/outline.nvim
  -- Fork of symbol-outline which is now archived.
  {
    "hedyhli/outline.nvim",
    config = function()
      require("outline").setup({
        -- symbols.filter = {
        --   default = { 'String', exclude = true },
        --   python = { 'Function', 'Class' },
        -- },
      })
    end,
  },
  -- }}}

  -- plugin-readme {{{
  -- https://github.com/selectnull/plugin-readme.nvim
  -- When you mess with the Neovim configuration (instead of working), it's
  -- often needed to read the plugin documentation. This plugin attempts to
  -- make that easier.
  --
  -- List all installed plugins and preview their README file. Press ENTER and
  -- open the plugin github repository in a browser
  {
    "selectnull/plugin-readme.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local readme = require "plugin-readme"
      vim.keymap.set("n", "<leader>hp", readme.select_plugin, { silent = true, desc = "Telescope Preview/Goto the plugin README files & help docs." })
    end,
  },
  -- }}}

  -- todo-comments {{{
  -- https://www.github.com/folke/todo-comments.nvim
  -- See all of the TODO/FIXME/NOTE ... comments in a file.
  {
    'folke/todo-comments.nvim',
    config = function()
      require("todo-comments").setup{
        FIX = {
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "XXX", "FIX", "TESTING", "ERICK" },
        },
        NOTE = {
          alt = { "NOTE", "INFO", "DONE", "DISCUSS" },
        },
        highlight = {
          max_line_len = 200,
        },
      }

      -- TODO: THis is global, make it just for the current buffer.
      vim.keymap.set('n', '<leader>dc', '<cmd>TodoTelescope<cr>')
    end,
  },
  -- }}}

  -- vim-argwrap {{{
  {
    'AckslD/nvim-trevJ.lua',
    config = function()
      require("trevj").setup({})
    end,
  },
  -- }}}

}
