-- vim: nu fdm=marker
return {

  -- aerial.nvim {{{
  -- https://github.com/stevearc/aerial.nvim
  -- A code outline for symbols and quick navigation in the current buffer.
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = { "lsp", "treesitter", "markdown" },
      layout = {
        default_direction = "right",
      },
      autojump = true,
      highlight_on_jump = 500,
    },
  },
  -- }}}

  -- celeste_comment.nvim {{{
  -- https://github.com/celeste3z/celeste_comment.nvim
  -- VSCode/TextEdit style commenting.
  --
  -- Mappings:
  --   gcc - Line comment current line (n)
  --   gb/gbc - Block comment by motion/current line.
  --   gc/gb<text_object)
  --   gco - Insert comment below
  --   gcO - Insert comment above.
  { "celeste3z/celeste_comment.nvim",
       lazy = false,
       opts = {
         keep_selection = "adjust | expand_block",
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
        scope = {
          highlight = highlight,
          show_start = false,
          show_end = false,
        },
        -- scope = { enabled = true },
      })
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  -- }}}

  -- Auto pairs {{{
  -- https://github.com/windwp/nvim-autopairs
  -- What it says.  Also allows you to create/set custom rules for pairing.
  {
    'windwp/nvim-autopairs',
      event ="InsertEnter",
      config = true,
      opt = {
          enable_check_bracket_line = false,
          disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
          map_c_h = false, -- Map the <C-h> key to delete a pair
          map_c_w = false, -- map <c-w> to delete a pair if possible
        },
    },
  -- }}}

  -- 1. nvim-devdocs
  --  Thu Jan 08 2026 12:18:01
  --  archived.
  --
  -- 2. apidocs.nvim
  --
  -- devdocs.nvim
  -- Thu Jan 08 2026 12:17:33
  -- - used, shows raw markdown (ugly) and using it is clunky.
  --
  -- browse.nvim -> supports searching Devdocs

  -- apidocs.nvim {{{
  -- https://github.com/emmanueltouzery/apidocs.nvim
  -- An integration of devdocs.io in neovim.
  {
    'emmanueltouzery/apidocs.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- or, 'folke/snacks.nvim'
    },
    cmd = { 'ApidocsSearch', 'ApidocsInstall', 'ApidocsOpen', 'ApidocsSelect', 'ApidocsUninstall' },
    config = function()
      require('apidocs').setup()
      -- Picker will be auto-detected. To select a picker of your choice explicitly you can set picker by the configuration option 'picker':
      -- require('apidocs').setup({picker = "snacks"})
      -- Possible options are 'ui_select', 'telescope', and 'snacks'
    end,
    keys = {
      { '<leader>hd', '<cmd>ApidocsOpen<cr>', desc = 'Search Api Doc' },
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
