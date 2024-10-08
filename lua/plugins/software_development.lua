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
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  -- }}}

  -- indent-blankline {{{
  -- https://github.com/lukas-reineke/indent-blankline.nvim
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

      require("ibl").setup({
        scope = { enabled = true },
      })
    end,
  },
  -- }}}

  -- neotest {{{
  -- Run tests from within neovim
  -- TODO: Clean up keymaps for calling tests and displaying output.
  -- https://github.com/nvim-neotest/neotest
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

  -- nvim-devdocs {{{
  -- https://github.com/luckasRanarison/nvim-devdocs
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      wrap = true,
      dir_path = vim.fn.stdpath("data") .. "~/MyStuff/neovimrc/devdocs",
      float_win = {
        height = 35,
      },
      previewer_cmd = "glow",
      cmd_args = { "-s", "dark", "-w", "80" },
    }
  },
  -- }}}

  -- nvim-lint {{{
  -- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file
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
        --
        {
          "selectnull/plugin-readme.nvim",
          dependencies = {
            "nvim-telescope/telescope.nvim",
          },
          config = function()
            local readme = require "plugin-readme"
            vim.keymap.set("n", "<leader>hp", readme.select_plugin, {})
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
          alt = { "NOTE", "INFO", "DONE" },
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
