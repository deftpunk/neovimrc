return {

  -- Treesitter {{{
  -- Modern syntax highlighting
	{
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- https://github.com/p00f/nvim-ts-rainbow/issues/30#issuecomment-850991264
      local parsers = require("nvim-treesitter.parsers")
      local enabled_list = { "bash", "clojure",  "commonlisp", "fennel", "gitcommit","gitignore", "go", "lua", "markdown", "markdown_inline", "python", "ruby", "rust", "vimdoc"}

      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "bash",
          "c",
          "clojure",
          "cmake",
          "commonlisp",
          "dockerfile",
          "gitcommit",
          "gitignore",
          "go",
          "html",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "nim",
          "Python",
          "query",
          "ruby",
          "rust",
          "toml",
          "vimdoc",
          "yaml"
        },
        highlight = {
          enable = true,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = 25000,
          colors = {"#ab47bc", "#ec407a", "#42a5f5", "#ffab91", "#82e0aa", "#ff7043" },
          -- Enable for certain filetypes.
          disable = vim.tbl_filter(
          function(p)
            local disable = true
            for _, lang in pairs(enabled_list) do
              if p==lang then disable = false end
            end
            return disable
          end,
          parsers.available_parsers()
          )
        }
      }
    end,
  },

  -- nvim-treesiter-context {{{
  -- Show function context at the top of the file.
  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  {'nvim-treesitter/nvim-treesitter-context'},
  -- }}}

  -- nvim-treesitter-textobjects {{{
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- TODO: take a look at creating our own textobjects
  -- import lines beginning & ending in Python
  --
  -- Treesitter textobjects tutorial.
  -- https://www.josean.com/posts/nvim-treesitter-and-textobjects
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",

              -- You can use the capture groups defined in textobjects.scm
              -- If for example a keymap is something like a= then you can do va=, da=, ca= or ya= on this text object.
              -- Builtin objects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
              ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
              ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

              ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

              -- ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
              -- ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

              ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
              ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
              ["<leader>nm"] = "@function.outer", -- swap function with next
            },
            swap_previous = {
              ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
              ["<leader>pm"] = "@function.outer", -- swap function with previous
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = { query = "@call.outer", desc = "Next function call start" },
              ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]F"] = { query = "@call.outer", desc = "Next function call end" },
              ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
              ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
              ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
              ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
              ["[C"] = { query = "@class.outer", desc = "Prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
          },
        },
      })

      -- Configured repeating movements with ; and , and also
      -- maintain the built in vim functionality to use these keys to repeat f, F,
      -- t and T movements. ; will go the direction you were moving previously and
      -- , will go the opposite direction you were moving in.
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

    end,
  },
  -- }}}

  -- hlargs {{{
  -- https://github.com/m-demare/hlargs.nvim
  -- Highlight argument definitions and usages
  -- supported languages: go, lua, Python, ruby, rust
  {
      'm-demare/hlargs.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        require('hlargs').setup()
      end,
  },
  -- }}}

}
